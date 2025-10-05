CREATE TABLE eleve(id_e INT PRIMARY KEY , 
                   nom VARCHAR(50) NOT NULL,
                   prenom VARCHAR(50) NOT NULL, 
                   e_maison VARCHAR(50) NOT NULL,
                   FOREIGN KEY (e_maison) REFERENCES maison(m_nom));
                   
CREATE TABLE  maison(m_nom VARCHAR (50) PRIMARY KEY,
					 device VARCHAR(50),
                     animal VARCHAR(50));
                     
CREATE TABLE cours(id_c INT PRIMARY KEY,
				   nom_c VARCHAR (50),
                   id_p INT, 
                   FOREIGN KEY  (id_p) REFERENCES proffesseur(id_p));
                   
CREATE TABLE proffesseur (id_p INT,
                          nom  VARCHAR(50),
                          prenom VARCHAR(50),
                          PRIMARY KEY (id_p));

CREATE TABLE suivre (id_e INT, 
                   id_c INT,
                   note INT,
                   PRIMARY KEY(id_e,id_c)
			);
			
            
CREATE TABLE attribution(m_nom VARCHAR(50),
                         id_p INT,
                         PRIMARY KEY (m_nom, id_p));
                   

                          
                   
                     
                     
                   
                   
                    