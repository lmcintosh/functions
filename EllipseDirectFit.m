function [x0 y0 rx ry phi] = EllipseDirectFit(XY)
%
%  Direct ellipse fit, proposed in article
%    A. W. Fitzgibbon, M. Pilu, R. B. Fisher
%     "Direct Least Squares Fitting of Ellipses"
%     IEEE Trans. PAMI, Vol. 21, pages 476-480 (1999)
%
%  Our code is based on a numerically stable version
%  of this fit published by R. Halir and J. Flusser
%
%     Input:  XY(n,2) is the array of coordinates of n points x(i)=XY(i,1), y(i)=XY(i,2)
%
%     Output: A = [a b c d e f]' is the vector of algebraic
%             parameters of the fitting ellipse:
%             ax^2 + bxy + cy^2 +dx + ey + f = 0
%             the vector A is normed, so that ||A||=1
%
%  This is a fast non-iterative ellipse fit.
%
%  It returns ellipses only, even if points are
%  better approximated by a hyperbola.
%  It is somewhat biased toward smaller ellipses.
%
centroid = mean(XY);   % the centroid of the data set

D1 = [(XY(:,1)-centroid(1)).^2, (XY(:,1)-centroid(1)).*(XY(:,2)-centroid(2)),...
      (XY(:,2)-centroid(2)).^2];
D2 = [XY(:,1)-centroid(1), XY(:,2)-centroid(2), ones(size(XY,1),1)];
S1 = D1'*D1;
S2 = D1'*D2;
S3 = D2'*D2;
T = -inv(S3)*S2';
M = S1 + S2*T;
M = [M(3,:)./2; -M(2,:); M(1,:)./2];
[evec,~] = eig(M);
cond = 4*evec(1,:).*evec(3,:)-evec(2,:).^2;
A1 = evec(:,cond>0);
A = [A1; T*A1];
A4 = A(4)-2*A(1)*centroid(1)-A(2)*centroid(2);
A5 = A(5)-2*A(3)*centroid(2)-A(2)*centroid(1);
A6 = A(6)+A(1)*centroid(1)^2+A(3)*centroid(2)^2+...
     A(2)*centroid(1)*centroid(2)-A(4)*centroid(1)-A(5)*centroid(2);
A(4) = A4;  A(5) = A5;  A(6) = A6;
A = A/norm(A);

% convert to ellipse parameters
a = A(1);
b = 0.5*A(2);
c = A(3);
d = 0.5*A(4);
f = 0.5*A(5);
g = A(6);

x0 = (c*d-b*f)/(b^2-a*c);
y0 = (a*f-b*d)/(b^2-a*c);
numerator = 2*(a*f^2 + c*d^2 + g*b^2 - 2*b*d*f - a*c*g);
denom1 = (b^2-a*c); denom2 = sqrt((a-c)^2 + 4*b^2);
rx = sqrt(numerator./(denom1*(denom2 - (a+c))));
ry = sqrt(numerator./(denom1*(-denom2 - (a+c))));

if b == 0
    if a <= c
        phi = 0;
    else
        phi = 0.5*pi;
    end
else
    if a <= c
        phi = 0.5*acot((a-c)/(2*b));
    else
        phi = 0.5*pi + 0.5*acot((a-c)/(2*b));
    end
end

end  %  EllipseDirectFit
