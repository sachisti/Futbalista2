include <vypinace.scad>;
include <spolocne.scad>;

module stlpik(vyska){
    cylinder(h=vyska, d=7, center=true, $fn=6);
    }

module diera_stlpik(){
    cylinder(h=70, d=velkost_diery, center=true,  $fn =100);
    }


module diera_pre_baterku()
{    
   translate([0,-35,29])
   {  
    translate([0,0,-12.5])
       cube([140,44,25],true);
    translate([50,-27,-1])    
       cube([22,3,10],true);
    translate([-50,-27,-1])    
       cube([22,3,10],true);
    translate([50,27,-1])    
       cube([22,3,10],true);
    translate([-50,27,-1])   
       cube([22,3,10],true);
  }    
}

module baterka()
{
  if (cele == 1){ 
    translate([0,-35,28])
      translate([0,0,-12.5])
        cube([138,42,23],true);  
  }  
}
    
module diery_pre_stlpiky_v_strednom_poschodi()
{
    translate([40,-85,0])
        diera_stlpik();

    translate([-40,-85,0])
        diera_stlpik();

    translate([90,-10,0])
        diera_stlpik();

    translate([-90,-10,0])
        diera_stlpik();

    translate([-45,80,0])
        diera_stlpik();

    translate([45,80,0])
        diera_stlpik();

    translate([0,45,0])
        diera_stlpik();

    translate([-75,-45,0])
        diera_stlpik();

    translate([75,-45,0])
        diera_stlpik();
}

module placka(){
  difference(){
     spolocna_placka();
     diery_pre_stlpiky_v_strednom_poschodi();
  }
}

module radice()
{
    cube([57,37,25]);
}
    
module diery_pre_radice()
{
    translate([3,3,30])
  cylinder(h=50,d=velkost_diery, center = true, $fn=100);
    
    translate([29,3,30])
  cylinder(h=50,d=velkost_diery, center = true, $fn=100);
    
    translate([55,3,30])
  cylinder(h=50,d=velkost_diery, center = true, $fn=100);   
}

 module zdroj()
{
    rotate([0,180,0])
      translate([-65,39,-25])
      {
        cube([43,20,13]);
      }
}

module diery_pre_zdroj()
{
    rotate([0,180,0])
      translate([-65,39,-25])
      {
        translate([6,18,0])
        cylinder(h=50,d=velkost_diery, center = true, $fn=100);
    
        translate([36,2,0])
          cylinder(h=50,d=velkost_diery, center = true, $fn=100);
      }   
}

module radicova_doska()
{
  translate([22,-60, 57]) 
    rotate([180,0,90])
    {  
      zdroj();   
      radice();
    }
}

module diery_pre_radic_a_zdroj()
{  
  translate([22,-60, 57]) 
    rotate([180,0,90])
    {  
      diery_pre_zdroj();   
      diery_pre_radice();
    }
} 

module arduino(){
 rotate([0,0,90])
 {
    translate([-64.5,-22.25,-48])
    {    
       cube([57,53,25]);
  
       translate([4,3,25])
          cylinder(h=50,d=7, center = false, $fn=6);
    
       translate([4,50.5,25])
           cylinder(h=50,d=7, center = false, $fn=6);
 
       translate([55,17,25])
           cylinder(h=50,d=7, center = false, $fn=6); 

       translate([55,45,25])
           cylinder(h=50,d=7, center = false, $fn=6);
    }     
 }
}
    
module diery_pre_arduino()
{
 rotate([0,0,90])
 {
     translate([-64.5,-22.25,-35])
     {    
         translate([4,3,25])
         cylinder(h=60,d=velkost_diery, center = false, $fn=100);
            
         translate([4,50.5,25])
         cylinder(h=60,d=velkost_diery, center = false, $fn=100);
         
         translate([55,17,25])
         cylinder(h=60,d=velkost_diery, center = false, $fn=100); 

         translate([55,45,25])
         cylinder(h=60,d=velkost_diery, center = false, $fn=100);
     }
 }
}

module nakresli_mobil(aky)
{
    if (aky == sony)
       cube([125,9.3,67],false);        
    else if (aky == samsung)
       cube([137,8,70],false);                
}

function extra_posun_pre_mobil() =
    (mobil == samsung) ? 35 : 0;

module mobil_10()
{
    posun = -29.5 + extra_posun_pre_mobil();
    translate([0,0,-40])
        translate([posun-65,11,-40]) 
            rotate([10,0,0])
                nakresli_mobil(mobil);
}

module mobil_20()
{
    posun = -29.5 + extra_posun_pre_mobil();
    translate([0,0,-40])
        translate([posun-65,25.1,-40]) 
            rotate([20,0,0])
                nakresli_mobil(mobil);
}

module vypinace()
{
    translate([-75,-15,39])
      rotate([0,180,90])
        switch_big();

    translate([53,-77,36])
      rotate([0,180,0])
        switch_kcd11();

    translate([-53,-69,36])
      rotate([0,180,180])
        switch_kcd11();
}

module diery_pre_vypinace()
{
    translate([-74,-13,36])
      rotate([0,180,90])
        cube([20,13,10]);

    translate([54,-77,36])
      rotate([0,180,0])
        cube([14,9,10]);

    translate([-54,-69,36])
      rotate([0,180,180])
        cube([14,9,10]);
        
}

module stlpiky_pre_mobil()
{
    translate([50,0,10])
      stlpik(34);
    translate([45,8,10])
      stlpik(34);
    translate([-60,10,10])
      stlpik(34);
    translate([-87,6,10])
      stlpik(34);
}

module suciastky_stredneho_poschodia()
{
    baterka();
    radicova_doska();
    arduino();
    mobil_20();    
    stlpiky_pre_mobil();
    vypinace();
}

module predny_vyrez()
{
  translate([0,145,0])     
  cylinder(h=80,d=152, center = true, $fn=100);  
  translate([-60,83,25])
   cube([120,20,10]); 
}

module diery_na_kable()
{
    translate([-85,-8 ,20])
       cube([15,9,15]);
    translate([15,-5,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([-7,-5,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([-31,-5,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([-18,5,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([6,5,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([-20,20,20])
       cylinder(h=15, d=7, $fn=50);
    translate([20,20,20])
       cylinder(h=15, d=7, $fn=50);
    translate([-3,-61,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([-17,-61,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([12,-61,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([87,-21,20])
       cylinder(h=15, d=7, $fn=50);
}

module diery_pre_drziak_na_mobil()
{
    translate([50,0,25])
      cylinder(d=velkost_diery, h=10, center=false, $fn=50);
    translate([55,8,25])
      cylinder(d=velkost_diery, h=10, center=false, $fn=50);
    translate([45,8,25])
      cylinder(d=velkost_diery, h=10, center=false, $fn=50);
    translate([-60,10,16])
      cylinder(d=velkost_diery, h=19, center=false, $fn=50); 
    translate([-87,6,25])
      cylinder(d=velkost_diery, h=10, center=false, $fn=50);
    translate([-78,0,25])
      cylinder(d=velkost_diery, h=10, center=false, $fn=50);    
}

module drziak_na_mobil_10()
{
    translate([0,0,-40])
    {
        difference()
        {
            union()
            {
                translate([-31 - 65,12,10]) 
                   rotate([10,0,0])
                      cube([10,5,20],false);
                
                translate([-34 - 65 ,1,10]) 
                   rotate([10,0,0])
                      cube([3.5,15,20],false);
                
                translate([-34.5 - 65,-0.7,0]) 
                   rotate([10,0,0])
                      cube([12,5,30],false);
                
                translate([23 - 65,-0.7,0]) 
                   rotate([10,0,0])
                      cube([10,5,30],false); 
                
                translate([63 - 65,-0.7,0])
                   rotate([10,0,0])
                      cube([10,5,30],false);
                
                translate([87 - 62.5,12,10]) 
                   rotate([10,0,0])
                      cube([10,5,20],false);
                      
                translate([94.5 - 62.5,0,10]) 
                   rotate([10,0,0])
                      cube([5,15,20],false);    

                translate([-99, -5, 28])
                   cube([160,20,5]);
            }        
            translate([0,0,25])
               cube([30, 9.7, 10]);
            diery_pre_drziak_na_mobil();
        }
    }
}

module drziak_pre_sony()
{
    translate([0,0,-40])
    {
        difference()
        {
            union()
            {
                translate([-31 - 65,17,10]) 
                   rotate([20,0,0])
                      cube([10,5,20],false);
                
                translate([-34 - 65 ,7,8]) 
                   rotate([20,0,0])
                      cube([3.5,15,21],false);
                
                translate([-34.5 - 65,5.3,0]) 
                   rotate([20,0,0])
                      cube([12,5,30],false);
                
                translate([23 - 65,5.3,0]) 
                   rotate([20,0,0])
                      cube([10,5,30],false); 
                
                translate([63 - 65,5.3,0]) 
                   rotate([20,0,0])
                      cube([10,5,30],false);
                
                translate([87 - 62.5,17,10]) 
                   rotate([20,0,0])
                      cube([10,5,20],false);
                      
                translate([94.5 - 62.5,7,8]) 
                   rotate([20,0,0])
                      cube([5,15,21.1],false);    

                translate([-99, -5, 28])
                   cube([160,20,5]);
            }        
            translate([0,1.886,24])
              rotate([20,0,0])
               cube([30, 9.414, 10]);
            diery_pre_drziak_na_mobil();
        }
    }
}

module drziak_pre_samsung()
{
    posun = 35;
    translate([0,0,-40])
    {
        difference()
        {
            union()
            {
                translate([posun -31 - 65,17,10]) 
                   rotate([20,0,0])
                      cube([10,5,20],false);
                
                translate([posun -35.5 - 65 ,7,8]) 
                   rotate([20,0,0])
                      cube([5,15,21],false);
                
                translate([posun -35.5 - 65,5.3,0]) 
                   rotate([20,0,0])
                      cube([12,5,30],false);
                
                translate([posun + 23 - 65,5.3,0]) 
                   rotate([20,0,0])
                      cube([10,5,30],false); 
                
                translate([posun + 63 - 65,5.3,0]) 
                   rotate([20,0,0])
                      cube([10,5,30],false);
                
                translate([131.1 - 62.5,17,10]) 
                   rotate([20,0,0])
                      cube([10,5,20],false);
                      
                translate([141 - 62.5,7,8]) 
                   rotate([20,0,0])
                      cube([5,15,21.1],false);

                translate([-92, -5, 28])
                   cube([175,20,5]);
            }        
            diery_pre_drziak_na_mobil();
        }
    }
}    

module drziak_na_mobil()
{
    if (mobil == sony)
        drziak_pre_sony();
    else
        drziak_pre_samsung();
}

module chranic_vypinaca()
{
    translate([-70,-22,30])
      rotate([0,180,90])
        cube([22,3,12]);   
    translate([-90,-18,30])
      rotate([0,180,90])
        cube([20,2.5,12]); 
    translate([76,-18,30])
      rotate([0,180,90])
        cube([22,4,12]);       
}

// p == 2 alebo p == 3  - ktore poschodie
module stredne_poschodie(p)
{
 difference()
 {
     union() {
        if ((cele == 1) || (p == 2))
        {
           placka();
           chranic_vypinaca();
        }
        if ((cele == 1) || (p == 3))
           drziak_na_mobil();
     }
  diera_pre_baterku();
  diery_pre_arduino();
  predny_vyrez();
  diery_pre_vypinace();
  diery_pre_radic_a_zdroj();
  diery_na_kable();
  diery_pre_drziak_na_mobil();  
 }
     if (cele)
         suciastky_stredneho_poschodia();
}

module test_diera_velky_vypinac()
{
    intersection()
    {        
        stredne_poschodie(2);
        translate([-70,-10,33])
          rotate([0,180,90])
             cube([28,22,20]);
    }
}

module test_diera_maly_vypinac()
{
    intersection()
    {
        stredne_poschodie(2);
        
        translate([58,-82,38])
          rotate([0,180,0])
             cube([25,20,20]);        
    }
}

//cele = 0;  
//mobil = samsung;
//stredne_poschodie(3);
