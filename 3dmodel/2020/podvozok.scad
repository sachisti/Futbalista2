include <spolocne.scad>;

module diera_pre_stlpik(){
    cylinder(h=70, d=velkost_diery, center=true, $fn=50);
    }

module lopta(){
if (cele == 1){    
sphere(d=65, $fn=100);
}    
}
module podstava()
{
    cylinder(h=2, d=22, $fn=100);
}

module stit()
{
    cylinder(h=12, d=10, $fn=100);
}

module base()
{
    podstava();
    stit();
}


module vrchDiera()
{
    translate([0, 0, -0.1])
      cylinder(h=12.2, d=6, $fn=100);
    
}

module jamy()
{
    translate([8, 0, -0.1])
       cylinder(h=2.2, d=3, $fn=100);
    translate([-8, 0, -0.1])
       cylinder(h=2.2, d=3, $fn=100);
    translate([0, 8, -0.1])
       cylinder(h=2.2, d=3, $fn=100);
    translate([0, -8, -0.1])
       cylinder(h=2.2, d=3, $fn=100);
}

module cervik()
{
    rotate([0, 0, 45])
    translate([-5.5, 0, 8])
        rotate([0, 90, 0])
            cylinder(h=11, d=3, $fn=100);
}
module koza()
{
    difference()
    {
        base();
        vrchDiera();
        jamy();
        cervik();
    }
}

module koliesko(){
    
 cylinder(h=10, d=65, $fn=100);    
}



module Lko()
{
   cube([40, 43, 3.3]);
   cube([40, 3.3, 27]);

    translate([20,3.3,27]) 
    {
      rotate([90,0,0])
      {
        cylinder(h=3.3, d=40, $fn=100);
      }
    }
}

module hornyVrt()
{
    rotate([-90,0,0])
        cylinder(h=3.5, d=3, $fn=100);
}

module dolnyVrt()
{
    rotate([0,0,0])
        cylinder(h=8.5, d=3, $fn=100);
}

module velkyOtvor()
{
    translate([20,-0.1,34])
      rotate([-90,0,0])
          cylinder(h=3.5, d=13, $fn=100);
    translate([20,-0.1, 20]) 
    {
      rotate([-90,0,0])
      {
          cylinder(h=3.5, d=13, $fn=100);
      }
    }
    translate([13.5,-0.1, 20]) 
    {
            cube([13, 3.5, 14]);
    }
}

module horneDiery()
{
//1    
    translate([4.5, -0.1, 27])
        hornyVrt();
    
//2
    translate([35.5, -0.1, 27])
        hornyVrt();
    
//3
    translate([20, 0, 27])
        rotate([0,-60,0])
            translate([15.5, -0.1, 0])
                hornyVrt();
    
//4
    translate([20, 0, 27])
        rotate([0,60,0])
            translate([15.5, -0.1, 0])
                hornyVrt();
    
//5
    translate([20, 0, 27])
        rotate([0,60,0])
            translate([-15.5, -0.1, 0])
                hornyVrt();
                
//6
    translate([20, 0, 27])
        rotate([0,-60,0])
            translate([-15.5, -0.1, 0])             hornyVrt();
            
}

module dolneDiery()
{
    translate([5, 9.5, -5.1])
        dolnyVrt();
    translate([5, 33.5, -5.1])
        dolnyVrt();
    translate([35, 9.5, -5.1])
        dolnyVrt();
    translate([35, 33.5, -5.1])
        dolnyVrt();
}

module diery()
{
    velkyOtvor();
    horneDiery();
    dolneDiery();

}

module lko()
{
    difference() 
    {
        Lko();
        diery();
    }
}

module vrch()
{
    translate(v = [0, 0, 44.7]) 
    { 
        cylinder(h=6, r=5, center=false, $fn=100); 
    }
    translate(v = [0, 0, 50.7]) 
    { 
        cylinder(h=15.5, r=3, center=false, $fn=100);
    }
}

module motor()
{
    translate([0,-12,0])
    {
        rotate([90,0,0])
        {        
            cylinder(h=22.7, r=16.5, center=false, $fn=100);
            translate(v = [0, 0,22.7]) 
            { 
                cylinder(h=22, r=18.5, center=false, $fn=100); 
            }

            translate(v = [0, -7, 0])
            {
                vrch();   
            }
        }
    }
}


module motorsl()
{
    rotate([0,180,0])
    motor();
    translate([20,-60,27])
        rotate([0,180,0])
    {
            lko(); 
        }   
}

module vsetko()
{
    if (cele == 1){
    motorsl();
    translate([0,-78.2,7])
    {
        rotate([-90,0,0])
        koza();    
    }    
    translate([0,-88.2,7])
    {
        rotate([-90,0,0])
        koliesko();    
    }    
}
}

module dieryVPodvozku()
{
    translate([20,-60,27])
        rotate([0,180,0])
            dolneDiery();
}

module robot()
{
    if (cele == 1){
    vsetko();
    } 
    rotate([0,0,120]) vsetko(); 
    rotate([0,0,-120]) vsetko(); 

    difference()
    {
        podvozok();
        
        translate([0,120,7])
        {
            sphere(d=100, $fn=100);
        }
        
        dieryVPodvozku();
        rotate([0,0,120]) dieryVPodvozku(); 
        rotate([0,0,-120]) dieryVPodvozku(); 
    }

    translate([0,140,7])
    {
        lopta();
    }
}
    
module podvozok()
{   
    spolocna_placka();
    
    intersection(){
       translate([0,100,7])
  cylinder(h=25, r=43, center=false, $fn=100); 
        translate([0,0,7])
        {
            cylinder(h=25, r=100, center=false, $fn=100);
        }
        
        }
  
    
}

module senzor(){
 cube([32,10,3.5]);
    translate([6,0,0])
    cube([20,10,8]);
    
    translate([29,13,3])
    cylinder(h=10, r=1, center=true,$fn=100);
    
    translate([29,-3,3])
    cylinder(h=10, r=1, center=true,$fn=100);
    
    translate([3,13,3])
    cylinder(h=10, r=1, center=true,$fn=100);
    
    translate([3,-3,3])
    cylinder(h=10, r=1, center=true,$fn=100);
    
}

module dieryns(){
    
translate([17,38,25])
rotate([0,0,30]){
senzor();
}

translate([-13,50,25])
rotate([0,0,-210]){
senzor();
}


translate([-35,-35,25])
rotate([0,0,270]){
senzor();
}

translate([35,-35,25])
rotate([0,0,270]){
senzor();
}

translate([-45,-15,25])
rotate([0,0,-210]){
senzor();
}

translate([50,-20,25])
rotate([0,0,30]){
senzor();
}

}
module wow()
{
  difference()
  {    
    robot();
    dieryns();
  }
}

module diery_pre_stlpiky_v_dolnom_poschodi()
{
    translate([40,-85,0])
      diera_pre_stlpik();

    translate([-40,-85,0])
      diera_pre_stlpik();

    translate([90,-10,0])
      diera_pre_stlpik();

    translate([-90,-10,0])
      diera_pre_stlpik();

    translate([-45,80,0])
      diera_pre_stlpik();

    translate([45,80,0])
      diera_pre_stlpik();

    translate([0,45,0])
      diera_pre_stlpik();

    translate([-75,-45,0])
      diera_pre_stlpik();

    translate([75,-45,0])
      diera_pre_stlpik();

}

module dolne_poschodie()
{
  difference()
  {
    wow(); 
    diery_pre_stlpiky_v_dolnom_poschodi();
  }
}

//dolne_poschodie();