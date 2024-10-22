unit MyConst;

interface
Const FloorFog: array[0..46] of byte = (
   $21,
   $01,
   $02,
   $03,
   $04,
   $05,
   $0E,
   $0F,
   $1E,
   $1F,
   $20,
   $17,
   $10,
   $22,
   $23,
   $22,
   $13,
   $2F,
   $60,
   $61,
   $62,
   $40,
   $41,
   $18,
   $19,
   $1A,
   $1B,
   $1C,
   $28,
   $29,
   $42,
   $63,
   $64,
   $10,
   $49,
   $4B,
   $80,
   $80,
   $80,
   $80,
   $84,
   $85,
   $8E,
   $97,
   $A0,
   $21,
   $A0
);

Const NPC51Name:array[0..45,0..15] of string = (
    ('','','','','','','','','','','','','','','',''),
    ('Forest Box','Booma','Gigobooma','Gobooma','Rag Rappy','Al Rappy','Mothmant','Monest','Barbarous Wolf','Savage Wolf','Chao npc','Crashed Probe','Crashed Probe on side','CRASH','CRASH','CRASH'),
    ('Forest Box','Booma','Gigobooma','Gobooma','Rag Rappy','Al Rappy','Mothmant','Monest','Barbarous Wolf','Savage Wolf','Chao npc','Mini Hidebear','Hibdebear','Hildeblue','Crashed Probe','Crashed Probe on side'),
    ('Caves Box','Nano Dragon','Pan Arms','Hiddom','Migium','Pal Shark','Guil Shark','Evil Shark','Grass Assasin','Mini Grass Assasin','Poison Lilly','CRASH','CRASH','CRASH','CRASH','CRASH'),
    ('Caves Box','Nano Dragon','Slime','Rare Slime','Pal Shark','Guil Shark','Evil Shark','Grass Assasin','Mini Grass Assasin','Poison Lilly','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH'),
    ('Caves Box','Nano Dragon','Pan Arms','Hiddom','Migium','Slime','Rare Slime','Pal Shark','Guil Shark','Evil Shark','Grass Assasin','Mini Grass Assasin','Poison Lilly','CRASH','CRASH','CRASH'),
    ('Mine Box','Canadine','canane','Gillchic','Dubchic','Garanz','Garanz broke','Sinow blue','Sino gold','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH'),
    ('Mine Box','Canadine','canane','Gillchic','Dubchic','Garanz','Garanz broke','Sinow blue','Sino gold','Litle flying robot','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH'),
    ('Bulclaw','Claw','Dark Beltre','Del Saber','SoDieman','LaDieman','Dieman','Chaos sorcerer','Pillar Trap','Poison bulb','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH'),
    ('Chaos brigner','Del Saber','SoDieman','LaDieman','Dieman','Pillar Trap','Poison bulb','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH'),
    ('Dark Beltre','Chaos brigner','SoDieman','LaDieman','Dieman','Chaos sorcerer','Pillar Trap','Poison bulb','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH'),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('Rappy','Love rappy','Mothmant','Monest','Dark Beltre','SoDieman','LaDieman','Dieman','Mini Hidebear','Hibdebear','Hildeblue','Grass Assasin','Mini Grass Assasin','Poison Lilly','Pillar Trap','CRASH'),
    ('Rappy','Love rappy','Mothmant','Monest','Dark Beltre','SoDieman','LaDieman','Dieman','Mini Hidebear','Hibdebear','Hildeblue','Grass Assasin','Mini Grass Assasin','Poison Lilly','Pillar Trap','CRASH'),
    ('Barbarous Wolf','Savage Wolf','Del Saber','Gillchic','Dubchic','Garanz','Garanz broke','Pan Arms','Hiddom','Migium','Pillar Trap','CRASH','CRASH','CRASH','CRASH','CRASH'),
    ('Barbarous Wolf','Savage Wolf','Del Saber','Gillchic','Dubchic','Pan Arms','Hiddom','Migium','Chaos sorcerer','Pillar Trap','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH'),
    ('Rappy','Love rappy','Ul gibbon','Zol Gibbon','Gee','CRASH','Merillias','CRASH','Meriltas','Gee nest','Small Rock','Small plant','Gi Gue','Mericarol','Gibbles','CRASH'),
    ('Rappy','Love rappy','Ul gibbon','Zol Gibbon','Gee','CRASH','Merillias','CRASH','Meriltas','Gee nest','Small Rock','Small plant','Gi Gue','Mericarol','Gibbles','CRASH'),
    ('Rappy','Love rappy','Ul gibbon','Zol Gibbon','Gee','CRASH','Merillias','CRASH','Meriltas','Gee nest','Small Rock','Small plant','Gi Gue','Mericarol','Gibbles','CRASH'),
    ('Rappy','Love rappy','Ul gibbon','Zol Gibbon','Gee','CRASH','Merillias','CRASH','Meriltas','Gee nest','Small Rock','Small plant','Gi Gue','Mericarol','Gibbles','CRASH'),
    ('Rappy','Love rappy','Ul gibbon','Zol Gibbon','Gee','CRASH','Merillias','CRASH','Meriltas','Gee nest','Small Rock','Small plant','Gi Gue','Mericarol','Gibbles','CRASH'),
    ('Seabeb Box','Recon','ReconBox','Dolphin','Dolmolm','Delbiter','Deldebth','Deldebth form 2','Sinow Zoa','Sinow zele','Sinow Zoa dead','Sinow Zele dead','Morfos','Dolmdarl','CRASH','CRASH'),
    ('Seabeb Box','Recon','ReconBox','Dolphin','Dolmolm','Delbiter','Deldebth','Deldebth form 2','Sinow Zoa','Sinow zele','Sinow Zoa dead','Sinow Zele dead','Morfos','Dolmdarl','CRASH','CRASH'),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('Rappy','Love rappy','Recon','Reconbox','CRASH','Zol Gibbon','Gee','Nights sit','Nights Fly','Merillias','Meriltas','Gee nest','Small Rock','Small plant','Dolmolm','Dolmdarl'),
    ('Recon','Recon box','Del Lilly','Gee nest','Gi Gue','Mericarol','Ill Gill','Gibbles','Delbiter','Epsilon','CRASH','CRASH','CRASH','CRASH','CRASH','CRASH'),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','',''),
    ('','','','','','','','','','','','','','','','')    );

    NPC51File:array[0..45,0..15] of integer = (
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (113,9,11,10,5,6,3,4,8,7,114,116,117,112,112,112),
    (113,9,11,10,5,6,3,4,8,7,114,115,1,2,116,117),
    (113,15,21,23,22,17,18,16,12,118,13,112,112,112,112,112),
    (113,15,19,20,17,18,16,12,118,13,112,112,112,112,112,112),
    (113,15,21,23,22,19,20,17,18,16,12,118,13,112,112,112),
    (113,28,29,50,24,25,25,26,27,112,112,112,112,112,112,112),
    (113,28,29,50,24,25,25,26,27,119,112,112,112,112,112,112),
    (40,39,37,30,43,42,41,31,120,121,112,112,112,112,112,112),
    (36,30,43,42,41,120,121,112,112,112,112,112,112,112,112,112),
    (37,36,43,42,41,31,120,121,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (5,6,3,4,37,43,42,41,115,1,2,12,118,120,121,112),
    (5,6,3,4,37,43,42,41,115,1,2,12,118,120,121,112),
    (8,7,30,50,24,25,25,21,23,22,120,112,112,112,112,112),
    (8,7,30,50,24,21,23,22,31,120,112,112,112,112,112,112),
    (5,51,59,60,54,112,52,112,53,122,123,124,55,56,61,112),
    (5,51,59,60,54,112,52,112,53,122,123,124,55,56,61,112),
    (5,51,59,60,54,112,52,112,53,122,123,124,55,56,61,112),
    (5,51,59,60,54,112,52,112,53,122,123,124,55,56,61,112),
    (5,51,59,60,54,112,52,112,53,122,123,124,55,56,61,112),
    (125,68,67,127,64,72,71,126,69,70,69,70,66,65,112,112),
    (125,68,67,127,64,72,71,126,69,70,69,70,66,65,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (112,112,112,112,112,112,112,112,112,112,112,112,112,112,112,112),
    (5,51,68,67,112,60,54,128,128,52,53,122,123,124,64,65),
    (68,67,83,122,55,56,82,61,72,84,112,112,112,112,112,112),
    (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
    (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
    (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
    (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
    (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
    (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
    (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
    (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
    (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),
    (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)    );

implementation

end.
