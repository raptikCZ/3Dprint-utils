// need convert to EN - mostly in Czech

//***********
// testing
/*roundedBox1(
	size = [20,20,20],
	radius = 5,
	top = true,
	bottom = true,
	resolution = 10
);
*/
/*
dira_sroub(
	h=10,
	d=6,
	zahloubeni=[13,1.5],
	l_zahloubeni = -3,
	hexagonal_zahloubeni = false,
	pomocne = false,
	h_pomocne = 0.3);
	natoceni = 30;
*/

/*
profil30(
	delka = 40,
	alupa = true,
	pozice = [0,0,0],
	rotace = [0,0,0]);
*/
/*
nema_motor(
	pozice = [0,0,0],
	rotace = [0,0,0],
	nema = [42.3,[22,2],31,3.1,[5,25]], // default nema 17 [motorXY, priruba[d1,vyska], roztec sroubku,sroubky,osa[d1,h]]
	h = 40,
	prodlouzeni = 0,
	h_sroubku = 10,
	sroubky = true,
	osa = true,
	pomocne = false,
	h_pomocne = 0.3,
	zahlub_sroubky = [10,1.5]
);
*/

//***********
// functions

module matka_past(
	pozice = [0,0,0],
	rotace = [0,0,0],
	protazeni = 10,
	matka = [6,2])
{
	translate(pozice)
	 rotate(rotace)
	{
		hull()
		{
		cylinder( d = matka[0], h = matka[1], center = false, $fn = 6);
		translate([0-matka[0]/2,protazeni,0])
		cube ( size = [matka[0], 0.01, matka[1]]);
		}
	}
}

module dira_sroub_oval(h = 10, d=3, l=10, segmentace = 40)
{
 $fn = segmentace;
 hull()
 {
  cylinder(r = d/2, h = h, center = false);
  translate ([l-d,0,0])
   cylinder(r = d/2, h = h, center = false);
 }
}

module dira_sroub(
	h=10,
	d=6,
	zahloubeni=[13,1.5],
	l_zahloubeni = 0,
	hexagonal_zahloubeni = false,
	pomocne = false,
	h_pomocne = 0.3,
	segmentovani = 60,
	natoceni = 30,
	prodlouzeni = 0)
{
 difference()
 {
  union()
  {
	hull()
	{
   	cylinder(h=h, r=d/2, $fn = segmentovani, center = false);
		translate([prodlouzeni,0,0])
   	cylinder(h=h, r=d/2, $fn = segmentovani, center = false);

	}
   translate([0,0,0+h-zahloubeni[1]+l_zahloubeni])
   if (hexagonal_zahloubeni == false)
   {
		hull()
		{
    		cylinder(h=zahloubeni[1], r=zahloubeni[0]/2, $fn = segmentovani, center = false);
		translate([prodlouzeni,0,0])
    		cylinder(h=zahloubeni[1], r=zahloubeni[0]/2, $fn = segmentovani, center = false);

		}
   }
    else
   {
 rotate (a = natoceni, v = [0,0,1])
		hull()
		{
	     cylinder(h=zahloubeni[1], r=zahloubeni[0]/2, $fn = 6, center = false);
			translate([prodlouzeni,0,0])
   	  		cylinder(h=zahloubeni[1], r=zahloubeni[0]/2, $fn = 6, center = false);
		}
   }
  }
  if (pomocne == true){
	translate([0,0,0+h-zahloubeni[1]+l_zahloubeni-h_pomocne])
	{
	 hull()
		{
	 		cylinder(h=h_pomocne, r=d/2+0.1, $fn = segmentovani);
			translate([prodlouzeni,0,0])
	 		cylinder(h=h_pomocne, r=d/2+0.1, $fn = segmentovani);
		}
	}
	}
 }
}

module roundedBox1(
	size = [20,20,20],
	radius = 5,
	top = true,
	bottom = true,
	resolution = 80
)
{

	z1 = top == true ? size[2] - radius : size[2];
	z = bottom == true ? z1 - radius : z1;
	x = size[0] - 2*radius;
	y = size[1] - 2*radius;
	center = [x,y,z];
	translate([0,0,bottom == true ? radius : 0])
	hull()
	{
	for ( xyz = [

/*	[x/2,y/2,0],
	[-x/2,y/2,0],
	[x/2,-y/2,0],
	[-x/2,-y/2,0]
*/
	[0,0,0],
	[x,0,0],
	[0,y,0],
	[x,y,0]
	])   
	{
	translate([radius,radius,0])
	 translate(xyz)
		{
			if (bottom == true)
			{
				sphere(r = radius, $fn = resolution);
			}
				cylinder( r = radius, h = z, center = false, $fn = resolution);
			if (top == true)
			{
				translate([0,0,z])
				sphere(r = radius, $fn = resolution);
			}
		}
	}
	}
}

module profil30(
	delka = 10,
	alupa = true,
	pozice = [0,0,0],
	rotace = [0,0,0])
{
vnitrek = [14,14,delka];
vnejsek = [30,30,delka];
translate(pozice)
 rotate(rotace)
	{
	 difference()//vnitrni ctverec a uhly
	 {
	  union()
	  {
	   translate([1.5,0,0])
	    rotate([0,0,45])
         cube(size = [40,2,delka]);
       mirror([1,0,0])
	    translate([-30+1.5,0,0])
	     rotate([0,0,45])
         cube(size = [40,2,delka]);

		translate ([vnejsek[0]/2-vnitrek[0]/2, vnejsek[1]/2-vnitrek[1]/2,0])
		cube(size = vnitrek, center = false);
	   } //end union
		translate([0,0,-0.1])
		{
		 if (alupa == true)
		 {
		  translate([vnejsek[0]/2-5,vnejsek[1]/2-5,0])
		   cube(size=[10,10,delka+0.2], center = false);
		 }
		  else
		 {
			translate([vnejsek[0]/2,vnejsek[1]/2,0])
			cylinder( d = m6_zavit, h = delka + 0.2,center = false, $fn = 60);
		 } // end elseif
		} //end translate
     } //end difference

	   difference()//vnejsi ctverec
		{
		translate ([0, 0,0])
		cube(size = vnejsek, center = false);
		translate([0,0,-0.1])
		{
		  translate([2,2,0])
		   cube(size=[26,26,delka+0.2], center = false);
		  for (a = [0 : 90 : 360])
			{
				translate([vnejsek[0]/2,vnejsek[1]/2,0])
				 rotate( [0,0,a])
					translate([12,-4,0])
					cube(size = [5,8,delka + 0.2]);
			}//end for
		} //end translate
	    }//end difference

	} //end translate
}//end module

module nema_motor(
	pozice = [0,0,0],
	rotace = [0,0,0],
	nema = [42.3,[22,2],31,3.1,[5,25]], // default nema 17 [motorXY, priruba[d1,vyska], roztec sroubku,sroubky,osa[d1,h]]
	h = 40,
	prodlouzeni = 0,
	h_sroubku = 10,
	sroubky = true,
	osa = true,
	pomocne = false,
	h_pomocne = 0.3,
	zahlub_sroubky = [10,1.5]
)
{
	translate(pozice)
	 rotate(rotace)
		{
			union()
			{
			//telo motoru
				color("black")
				hull()
				{
				translate([0-nema[0]/2,0-nema[0]/2,-h])
				{
					cube(size = [nema[0],nema[0],h], center = false);
					translate([prodlouzeni,0,0])
					cube(size = [nema[0],nema[0],h], center = false);
				}
				}
				color("silver")
				hull()
				{
					cylinder(d = nema[1][0], h = nema[1][1], $fn = 80, center = false);
					translate([prodlouzeni,0,0])
					cylinder(d = nema[1][0], h = nema[1][1], $fn = 80, center = false);

				}
			//generovani upevnovacich der
				if (sroubky == true)
				for (kXY = [
					[-1,-1],
					[1,-1],
					[1,1],
					[-1,1]
					])
					{
						translate([nema[2]/2*kXY[0],nema[2]/2*kXY[1],0])
						dira_sroub(
							h=h_sroubku,
							d=nema[3],
							zahloubeni = zahlub_sroubky,
							hexagonal_zahloubeni = false,
							prodlouzeni = prodlouzeni,
							pomocne = true,
							h_pomocne = h_pomocne
							);
					} 
				//osa
				if (osa == true)
					translate([0,0,nema[1][1]-0.1])
						color("silver")
						 hull()
							{
							cylinder( d = nema[4][0], h = nema[4][1]+0.1, center = false, $fn = 80);
							translate([prodlouzeni,0,0])
							cylinder( d = nema[4][0], h = nema[4][1]+0.1, center = false, $fn = 80);
							}
			}
		}
}
