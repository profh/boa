class ToDo < ActiveLdap::Base
  ldap_mapping dn_attribute: "cn",
               prefix: "ou=ToDos"
end
