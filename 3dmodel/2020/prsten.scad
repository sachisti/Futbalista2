module placka1()
{   
    difference ()
    {   
        translate([0,0,0])
        {
            cylinder(h=5, r=100, center=true, $fn=100);
        }
    } 
}

module placka2()
{   
    difference ()
    {   
        translate([0,0,0])
        {
            cylinder(h=6, r=85, center=true, $fn=100);
        } 
    } 
}



module predny_vyrez2()
{
  translate([0,145,0])     
  cylinder(h=80,d=190, center = true, $fn=100);  
  translate([-60,83,25])
   cube([120,20,10]); 
}

module stredne_poschodie2()
{
 difference()
 {
  placka2();

  predny_vyrez2();
 }
        
}


 module diera_stlpik(){
    cylinder(h=70, d=velkost_diery, center=true,  $fn =100);
    }
 
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


velkost_diery = 3.3;

difference()
 {
  placka1();
  stredne_poschodie2();
  translate([0,20,0])
   predny_vyrez2(); 
  diery_pre_stlpiky_na_rucku();
 }
 


