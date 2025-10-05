ALTER TABLE voiture MODIFY COLUMN v_autonomie DECIMAL(15,2) NULL,
                    MODIFY COLUMN v_cheveaux INT NULL;


ALTER TABLE emploiyé RENAME TO emploiye;


ALTER TABLE contrat
           CHANGE COLUMN co_etat_départ co_etat_depart VARCHAR(50);
           
           
           
           
           
ALTER TABLE employe
MODIFY COLUMN e_id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE employe
  ADD PRIMARY KEY (e_id);


ALTER TABLE clients
  MODIFY COLUMN cl_id INT NOT NULL AUTO_INCREMENT;
  
  
  ALTER TABLE clients
  ADD PRIMARY KEY (cl_id);
  
  