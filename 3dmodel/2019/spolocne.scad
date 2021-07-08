velkost_diery = 3.3;
cele = 1;

sony = 1;
samsung = 2;
mobil = samsung;

module dierak()
{
    translate([-30,-100,26])
    {
        cube([60,30,7], center=false);
    }
}  

module spolocna_placka()
{   
    difference ()
    {   
        translate([0,0,27])
        {
            cylinder(h=5, r=100, center=false, $fn=100);
        }
        dierak();
        rotate([0,0,120]) dierak(); 
        rotate([0,0,-120]) dierak(); 
    } 
}