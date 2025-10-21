
ALTER TABLE emploiye
MODIFY COLUMN e_id Varchar(50) NOT NULL AUTO_INCREMENT;

ALTER TABLE emploiye
  ADD constraint pk_e PRIMARY KEY (e_id);

ALTER TABLE clients
  MODIFY COLUMN cl_id INT NOT NULL AUTO_INCREMENT;
  
  ALTER TABLE clients
  ADD constraint pk_cl PRIMARY KEY (cl_id);
  
ALTER TABLE clients ADD permis VARCHAR(50) not null;

alter table clients 
add constraint cl_permis check (permis = "oui");



alter table maison
add constraint m_maison check (year(m_date) >= 2012);
