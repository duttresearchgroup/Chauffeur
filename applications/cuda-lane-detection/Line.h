#include "commons.h"

/** Represents Line in frame */
class Line {
    
private:
    double theta;
    double rho;
    
public:

    Line(double theta, double rho);
    
    /** Calculates y value of line based on given x */
    double getY(double x);
    
    /** Calculates x value of line based on given y */
    double getX(double y);
};
