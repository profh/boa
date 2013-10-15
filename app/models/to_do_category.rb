class ToDoCategory < ActiveLdap::Base
  ldap_mapping dn_attribute: "cn",
               prefix: "ou=ToDoCategories"
end
