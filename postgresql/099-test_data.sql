-- add test user and right

INSERT INTO usr (id,pswd_hsh,lst_upd,sub,family_name,given_name,middle_name,email) VALUES ('32f26b5c-ce2c-4de0-b6e6-de8f1134698b','{SHA256}8o86udWQG/YwawvA7ycGcMzC0Pvkg18DVpRQfIKZi9lKo+IchRUY54rzfzwH7w1AQcC5vpy8UggWoEf82+IBrQ','1677073237','test1@test.loc','Тестов','Тест','Тестович','test1@test.loc');
INSERT INTO RGH (SBJ_ID,OBJ_ID,RGH,TGS) VALUES ('test1@test.loc','its|test-app1','mng_rights_on','{}');