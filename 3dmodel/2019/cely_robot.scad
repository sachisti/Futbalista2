include <podvozok.scad>;
include <poschodie2.scad>;

module stlpiky_medzi_poschodiami()
{
    translate([40,-85,0])
        stlpik(50);

    translate([-40,-85,0])
        stlpik(50);

    translate([90,-10,0])
        stlpik(50);

    translate([-90,-10,0])
        stlpik(50);

    translate([-45,80,0])
        stlpik(50);

    translate([45,80,0])
        stlpik(50);

    translate([0,45,0])
        stlpik(50);

    translate([-75,-45,0])
        stlpik(50);

    translate([75,-45,0])
        stlpik(50);
}

module tri_poschodia()
{
    rotate([0,180,0])
    {
       dolne_poschodie();
        
       translate([0,0,2])        
          stlpiky_medzi_poschodiami();
       translate([0,0,-55])        
          stredne_poschodie(2);
    }
}

tri_poschodia();