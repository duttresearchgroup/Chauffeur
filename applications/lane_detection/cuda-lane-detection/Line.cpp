#include "Line.h"

Line::Line(double theta, double rho) {
    this->theta = theta;
    this->rho = rho;
}

/** Calculates y value of line based on given x */
double Line::getY(double x) {
    double thetaRadian = (theta * PI) / 180.0;
        
    return (rho  - x * cos(thetaRadian)) / sin(thetaRadian);
}

/** Calculates x value of line based on given y */
double Line::getX(double y) {
    double thetaRadian = (theta * PI) / 180.0;
        
    return (rho - y * sin(thetaRadian)) / cos(thetaRadian);
}
