class HColorField {
  	ArrayList<fieldPoint> fieldPoints = new ArrayList<fieldPoint>();

	int xBound, yBound;
	float maxDist;

	public HColorField( int x, int y ) {
		xBound = x;
		yBound = y;
		maxDist = sqrt( pow(xBound,2) + pow(yBound,2) );
	}

	public void addPoint(PVector pnt, String __pntColor, float radius) {
		color pntColor = color( hexToRGB(__pntColor) );
		fieldPoints.add( new fieldPoint( pnt, pntColor, radius) );
	}

	public color getColor(PVector location, color pntColor ) {
		float newR, newG, newB;
		float R, G, B;                
        ArrayList<Float> newReds = new ArrayList<Float>();
        ArrayList<Float> newGreens = new ArrayList<Float>();
        ArrayList<Float> newBlues = new ArrayList<Float>();

        for( int i = 0; i < fieldPoints.size(); i++ ) {
			float dist = PVector.dist( location, fieldPoints.get(i).getPos() );
			color fieldColor = fieldPoints.get(i).getColor();
			float radius = fieldPoints.get(i).getRadius();

			dist = constrain(dist, 0, maxDist*radius);

			newR = map( dist, 0, maxDist*radius, red(fieldColor), red(pntColor) );
			newG = map( dist, 0, maxDist*radius, green(fieldColor), green(pntColor) );
			newB = map( dist, 0, maxDist*radius, blue(fieldColor), blue(pntColor) );

			newReds.add(newR); newGreens.add(newG); newBlues.add(newB);
        }

        float[] reds = new float[newReds.size()];
        float[] greens = new float[newGreens.size()];
        float[] blues = new float[newBlues.size()];

        for( int i =0; i < newReds.size(); i++ ) {
            reds[i] 	= newReds.get(i);
            greens[i] 	= newGreens.get(i);
            blues[i] 	= newBlues.get(i);
        }

		return color(max(reds), max(greens), max(blues));
	}
}

public color hexToRGB( String __hex ) {
	int R, G, B;

	String sR =  __hex.charAt(0) + "" + __hex.charAt(1) ;
	String sG =  __hex.charAt(2) + "" + __hex.charAt(3) ;
	String sB =  __hex.charAt(4) + "" + __hex.charAt(5) ;

	R = unhex(sR);
	G = unhex(sG);
	B = unhex(sB);

	color colorRGB = color( R, G, B );
	return colorRGB;
}

private class fieldPoint {
	PVector pos;
	color pointColor;
	float radius;

	public fieldPoint(PVector __pos, color __col, float __radius) {
		pos = __pos;
		pointColor = __col;
		radius = __radius;
	}

	public color getColor() {
		return pointColor;
	}

	public PVector getPos() {
		return pos;
	}

	public float getRadius(){
		return radius;
	}
}


