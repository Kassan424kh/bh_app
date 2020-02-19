import os.path
import ssl

from flask_restful import abort
from ldap3 import Tls, Server, Connection, ALL_ATTRIBUTES, ALL
from ldap3.core.exceptions import LDAPSocketOpenError

config = dict()

# LDAP configurations
config['LDAP_HOST'] = 'ldaps://dc02.intern.satzmedia.de'
config['LDAP_PORT'] = 636
config['LDAP_USE_SSL'] = True
config['LDAP_USER_LOGIN_ATTR'] = 'mail'
config['LDAP_BIND_USER_DN'] = "gitlab@intern.satzmedia.de"
config['LDAP_BIND_USER_PASSWORD'] = "un1c0rn"
config['LDAP_BASE_DN'] = 'dc=intern,dc=satzmedia,dc=de'
config['LDAP_USER_DN'] = 'cn=users'
config['LDAP_ADD_SERVER'] = False
config['LDAP_CUSTOM_OPTIONS'] = {}

tls = Tls(validate=ssl.CERT_REQUIRED, version=ssl.PROTOCOL_TLSv1,
          ca_certs_file=os.path.dirname(__file__) + '/ca.pem')


def authUser(email="", password=""):
    userData = {"loggedIn": False, "email": "", "name": ""}

    try:
        server = Server(
            "ldaps://dc02.intern.satzmedia.de",
            port=636,
            use_ssl=True,
            tls=tls,
            get_info=ALL,
            connect_timeout=2
        )

        c = Connection(
            server,
            user=config['LDAP_BIND_USER_DN'],
            password=config['LDAP_BIND_USER_PASSWORD'],
        )

        AUTH_INFORMATION = "(mail={})".format(email)
        c.bind()
        c.search("dc=intern,dc=satzmedia,dc=de", AUTH_INFORMATION, attributes=ALL_ATTRIBUTES)

        try:
            indexOFUserDistinguishedName = str(c.entries[0]).index("distinguishedName: ") + len("distinguishedName: ")
            user_cn = str(c.entries[0])[indexOFUserDistinguishedName:].splitlines()[0]

            indexOFUserMail = str(c.entries[0]).index("mail: ") + len("mail: ")
            user_mail = str(c.entries[0])[indexOFUserMail:].splitlines()[0]

            indexOFUserName = str(c.entries[0]).index("name: ") + len("name: ")
            user_name = str(c.entries[0])[indexOFUserName:].splitlines()[0]
        except IndexError as error:
            abort(400, message="Login failed")
        if user_mail == email:
            authUserConnection = Connection(
                server,
                user=user_cn,
                password=password,
            )
            userData["loggedIn"] = authUserConnection.bind()
            userData["mail"] = user_mail
            userData["name"] = user_name

            return userData
    except (LDAPSocketOpenError):
        return userData
    return userData
