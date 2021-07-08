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
module suciastky_stredneho_poschodia()
{
    baterka();
    radicova_doska();
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
    translate([22,50,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([38,50,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([65,10,20])
       cylinder(h=15, d=6.5, $fn=50);
    translate([69,-5,20])
       cylinder(h=15, d=7, $fn=50);
}   
module chranic_vypinaca()
{
    translate([-70,-22,30])
      rotate([0,180,90])
        cube([22,3,12]);   
    translate([-76.8,-42,27])
      rotate([180,0,90])    
        opora(6,4,5);      
    translate([-90,-18,30])
      rotate([0,180,90])
        cube([20,2.5,12]); 
    translate([-96.3,-27,27])
      rotate([180,0,90])
        opora(6,4,5);       
    translate([76,-18,30])
      rotate([0,180,90])
        cube([22,4,12]);  
   translate([80,-32,27])
      rotate([180,0,-90]) 
        opora(7,4,5);
   translate([80,-19,27])
      rotate([180,0,-90]) 
        opora(7,4,5);
}

module raspberry(){
import("Raspberry_Pi_3_Light_Version.stl", convexity=3);

translate([6,5,-10]) 
   cylinder(h=50, d=3, center=true, $fn=100);

translate([64,5,-10]) 
   cylinder(h=50, d=3, center=true, $fn=100);
   
translate([6,54,-10]) 
   cylinder(h=50, d=3, center=true, $fn=100);
   
translate([64,54,-10]) 
   cylinder(h=50, d=3, center=true, $fn=100);
}

module diery_ard(){
    translate([2.7,2.7,25])
    cylinder (h = 50, d=3.5, center = true, $fn=100);
    
    translate([37.3,2.7,25])
    cylinder (h = 50, d=3.5, center = true, $fn=100);
    
    translate([2.7,37.3,25])
    cylinder (h = 50, d=3.5, center = true, $fn=100);
    
    translate([37.3,37.3,25])
    cylinder (h = 50, d=3.5, center = true, $fn=100);
}

 

module arduino(){
      cube([45,45,13],false);
      diery_ard();
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
     }
  diera_pre_baterku();
  predny_vyrez();
  diery_pre_vypinace();
  diery_pre_radic_a_zdroj();
  diery_na_kable();  
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

module drziak(){
   difference(){
     cube([30,3,30], true);
     rotate ([90,0,0])
     translate([-10.5,-10,0]) 
     cylinder(h = 10, d = 4, center =  true, $fn = 100);
     rotate ([90,0,0])
     translate([10.5,-10,0]) 
     cylinder(h = 10, d = 4, center =  true, $fn = 100);
     rotate ([90,0,0])
     translate([10.5,2.5,0]) 
     cylinder(h = 10, d = 4, center =  true, $fn = 100);
     rotate ([90,0,0])
     translate([-10.5,2.5,0]) 
     cylinder(h = 10, d = 4, center =  true, $fn = 100);
   }
}

module chranic(){
   cube([40,3,20], true); 
}

module kamera(){
translate([0,-6.5,-5])     
drziak();
}


cele = 0;


module diery_pre_stlpiky_na_rucku()
{
    translate([50,-81,0])
        diera_stlpik();

    translate([-50,-81,0])
        diera_stlpik();

    translate([-92,5,0])
        diera_stlpik();
    
    translate([92,5,0])
        diera_stlpik();
    
    translate([-50,72,0])
        diera_stlpik();

    translate([50,72,0])
        diera_stlpik();
    
    translate([30,70,0])
        diera_stlpik();
    
    translate([-30,70,0])
        diera_stlpik();
}

module opora(l, w, h)
{
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

difference(){
stredne_poschodie(2);

translate([6,-6,-13]) 
  arduino();

diery_pre_stlpiky_na_rucku();
    
rotate(a=[0,180,180])
  translate([-74,5.5,0]) 
    raspberry();
}

if (cele > 0)
{
translate([6,-6,-13]) 
  arduino();


rotate(a=[0,180,180])
  translate([-74,5.5,0]) 
    raspberry();
}
translate([0,48,20])
  kamera();

translate([6,26.2,29])
  rotate([180, 0, 180])
    opora(12,14,20);

