CREATE TABLE agence(a_nom VARCHAR(50) PRIMARY KEY,
                    a_pays VARCHAR(50) NOT NULL,
					a_ville VARCHAR(50) NOT NULL);
                    
                    
CREATE TABLE conces(c_nom VARCHAR(50),
                    c_pays VARCHAR(50),
                    c_type VARCHAR(50),
                    c_ville VARCHAR(50),
                    PRIMARY KEY (c_nom));
                    
CREATE TABLE maison( m_marque VARCHAR(50) PRIMARY KEY,
                     m_date DATE);
                     
                     
CREATE TABLE adresse(ad_adresse VARCHAR(50) PRIMARY KEY, 
                     ad_num_rue INT,
                     ad_nom_rue VARCHAR(50),
                     ad_codepostal INT);
					
CREATE TABLE emploiyé(e_id INT PRIMARY KEY,
					  e_nom VARCHAR(50),
                      e_prenom VARCHAR(50),
                      e_mail  VARCHAR(50),
                      e_age INT,
                      ad_adresse VARCHAR(50),
                      a_nom VARCHAR(50),
                      FOREIGN KEY (ad_adresse) REFERENCES adresse(ad_adresse) ON DELETE SET NULL,
                      FOREIGN KEY (a_nom) REFERENCES agence(a_nom));
                      
                      
CREATE TABLE clients(cl_id INT,
                     cl_nom VARCHAR(50),
                     cl_prenom VARCHAR(50),
                     cl_date DATE,
                     cl_age INT,
                     cl_email VARCHAR(50),
                     ad_adresse VARCHAR(50),
                     e_id INT,
                     PRIMARY KEY(cl_id),
                     FOREIGN KEY(ad_adresse) REFERENCES adresse(ad_adresse) ON UPDATE CASCADE,
                     FOREIGN KEY (e_id) REFERENCES emploiyé(e_id) ON UPDATE CASCADE);
					
                    
CREATE TABLE contrat(co_id VARCHAR(50) PRIMARY KEY, 
					 co_type VARCHAR(50),
                     co_date_debut DATE, 
                     co_date_fin DATE, 
                     co_statut_paiement VARCHAR(50),
                     co_etat_départ VARCHAR(50),
                     co_etat_fin VARCHAR(50),
                     cl_id INT,
                     FOREIGN KEY (cl_id) REFERENCES clients(cl_id) ON DELETE CASCADE );
                     
                     
                     
CREATE TABLE voiture(v_id VARCHAR(50) PRIMARY KEY,
                     v_etat VARCHAR(50),
                     v_couleur VARCHAR(50),
                     v_prix INT,
                     v_marque VARCHAR(50),
                     v_cheveaux INT(50),
                     v_type VARCHAR(50),
                     v_autonomie DECIMAL (15.2),
                     co_id VARCHAR(50),
                     c_nom VARCHAR(50),
                     FOREIGN KEY (co_id) REFERENCES contrat(co_id) ON DELETE SET NULL,
                     FOREIGN KEY (c_nom) REFERENCES conces(c_nom) ON DELETE CASCADE);
                     
                     
                     
                      
                      
                      
                     
                    