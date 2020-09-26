function I = rgb2grey(X)

origSize = size(X);

% Determine if input includes a 3-D array 
threeD = (ndims(X)==3);

% Calculate transformation matrix
coef = [0.2,0.6,0.2];

if threeD
  %RGB
  
  % Do transformation
  if isa(X, 'double') || isa(X, 'single')

    % Shape input matrix so that it is a n x 3 array and initialize output matrix  
    X = reshape(X(:),origSize(1)*origSize(2),3);
    sizeOutput = [origSize(1), origSize(2)];
    I = X * coef';
    I = min(max(I,0),1);

    %Make sure that the output matrix has the right size
    I = reshape(I,sizeOutput);
    
  else
    %uint8 or uint16
    I = imapplymatrix(coef, X, class(X));
  end

else
  I = X * coef';
  I = min(max(I,0),1);
  I = [I,I,I];
end