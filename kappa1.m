function kappa1(varargin)
global m f x w alpha 
args=cell(varargin);
nu=numel(args);
if isempty(nu)
    error('Warning: Matrix of data is missed...')
elseif nu>3
    error('Warning: Max three input data are required')
end
default.values = {[],0,0.05};
default.values(1:nu) = args;
[x w alpha] = deal(default.values{:});
if isempty(x)
    error('Warning: X matrix is empty...')
end
if isvector(x)
    error('Warning: X must be a matrix not a vector')
end
if ~all(isfinite(x(:))) || ~all(isnumeric(x(:)))
    error('Warning: all X values must be numeric and finite')
end   
if ~isequal(x(:),round(x(:)))
    error('Warning: X data matrix values must be whole numbers')
end
m=size(x);
if ~isequal(m(1),m(2))
    error('Input matrix must be a square matrix')
end
if nu>1 
    if ~isscalar(w) || ~isfinite(w) || ~isnumeric(w) || isempty(w)
        error('Warning: it is required a scalar, numeric and finite Weight value.')
    end
    a=-1:1:2;
    if isempty(a(a==w))
        error('Warning: Weight must be -1 0 1 or 2.')
    end
end
if nu>2
    if ~isscalar(alpha) || ~isnumeric(alpha) || ~isfinite(alpha) || isempty(alpha)
        error('Warning: it is required a numeric, finite and scalar ALPHA value.');
    end
    if alpha <= 0 || alpha >= 1
        error('Warning: ALPHA must be comprised between 0 and 1.')
    end
end
clear args default nu
m(2)=[]; 
tr=repmat('-',1,80);
if w==0 || w==-1
    f=diag(ones(1,m)); 
    disp('UNWEIGHTED COHEN''S KAPPA')
    disp(tr)
    kcomp;
    disp(' ')
end
if w==1 || w==-1
    J=repmat((1:1:m),m,1);
    I=flipud(rot90(J));
    f=1-abs(I-J)./(m-1); 
    disp('LINEAR WEIGHTED COHEN''S KAPPA')
    disp(tr)
    kcomp;
    disp(' ')
end
if w==2 || w==-1
    J=repmat((1:1:m),m,1);
    I=flipud(rot90(J));
    f=1-((I-J)./(m-1)).^2; 
    disp('QUADRATIC WEIGHTED COHEN''S KAPPA')
    disp(tr)
    kcomp;
end
return
end

function kcomp
global m f x alpha km kpa
n=sum(x(:));
x=x./n;
r=sum(x,2);
s=sum(x);
Ex=r*s;
pom=sum(min([r';s]));
po=sum(sum(x.*f));
pe=sum(sum(Ex.*f));
k=(po-pe)/(1-pe);
km=(pom-pe)/(1-pe);
ratio=k/km;
sek=sqrt((po*(1-po))/(n*(1-pe)^2));
ci=k+([-1 1].*(abs(-realsqrt(2)*erfcinv(alpha))*sek));
wbari=r'*f;
wbarj=s*f;
wbar=repmat(wbari',1,m)+repmat(wbarj,m,1);
a=Ex.*((f-wbar).^2);
var=(sum(a(:))-pe^2)/(n*((1-pe)^2));
z=k/sqrt(var);
p=(1-0.5*erfc(-abs(z)/realsqrt(2)))*2;
kpa=k;
fprintf('Observed agreement (po) = %0.4f\n',po)
fprintf('Random agreement (pe) = %0.4f\n',pe)
fprintf('Agreement due to true concordance (po-pe) = %0.4f\n',po-pe)
fprintf('Residual not random agreement (1-pe) = %0.4f\n',1-pe)
fprintf('Cohen''s kappa = %0.4f\n',k)
fprintf('kappa error = %0.4f\n',sek)
fprintf('kappa C.I. (alpha = %0.4f) = %0.4f     %0.4f\n',alpha,ci)
fprintf('Maximum possible kappa, given the observed marginal frequencies = %0.4f\n',km)
fprintf('k observed as proportion of maximum possible = %0.4f\n',ratio)
if k<0
    disp('Poor agreement')
elseif k>=0 && k<=0.2
    disp('Slight agreement')
elseif k>=0.21 && k<=0.4
    disp('Fair agreement')
elseif k>=0.41 && k<=0.6
    disp('Moderate agreement')
elseif k>=0.61 && k<=0.8
    disp('Substantial agreement')
elseif k>=0.81 && k<=1
    disp('Perfect agreement')
end
fprintf('Variance = %0.4f     z (k/sqrt(var)) = %0.4f    p = %0.4f\n',var,z,p)
if p<0.05
    disp('Reject null hypotesis: observed agreement is not accidental')
else
    disp('Accept null hypotesis: observed agreement is accidental')
end
return
end