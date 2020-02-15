import os.path
import ssl

from flask_ldap3_login import LDAP3LoginManager
from ldap3 import Tls, ServerPool, FIRST, Server, Connection

tls = Tls(validate=ssl.CERT_REQUIRED, version=ssl.PROTOCOL_TLSv1,
          ca_certs_file=os.path.dirname(__file__) + '/ca.pem')

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

ldap_manager = LDAP3LoginManager()
ldap_manager.init_config(config)

ldap_manager.add_server(
    config.get('LDAP_HOST'),
    config.get('LDAP_PORT'),
    config.get('LDAP_USE_SSL'),
    tls_ctx=tls,
)

server = Server("ldaps://dc02.intern.satzmedia.de", port=636, use_ssl=True, connect_timeout=1, tls=tls)


def authUser(email="", password=""):
    try:
        c = Connection(
            server,
            user="cn=" + email + ",cn=users,dc=intern,dc=satzmedia,dc=de",
            password=password,
            auto_bind=True,
            receive_timeout=1,
            auto_referrals=False
        )
        print(c.bind())
        return c.bind()
    except:
        return False
