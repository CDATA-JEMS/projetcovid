
--load data of closed company from HDFS to edit in Pig 

test = LOAD '/user/cloudera/datalake/prepared_data/LiqEnt/valeurs_mensuelles.csv' USING PigStorage(';') AS (
            date : chararray,
            NBFerme : chararray,
            rate : chararray);
            
            
            
--remove header           
 	 testun = FILTER test BY date != 'date';
      

-- replace des double cote to space 
     testdeux = FOREACH testun GENERATE REPLACE(date,'[\\"]',''), REPLACE(NBFerme,'[\\"]',''), REPLACE(rate,'[\\"]','');


-- save data in EntrepriseFermeFR_Data

STORE testdeux into '/user/cloudera/datalake/prepared_data/LiqEnt/LiqEnt_Data' using PigStorage(';');
