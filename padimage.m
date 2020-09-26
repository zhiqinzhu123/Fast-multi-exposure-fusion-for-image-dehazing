function b = padimage(a,padSize)

method = 'symmetric';
direction = 'both';

% compute indices then index into input image
aSize = size(a);
switch method
    case 'circular'
        aIdx = CircularPad(aSize, padSize, direction);
    case 'symmetric'
        aIdx = SymmetricPad(aSize, padSize, direction);
    case 'replicate' 
        aIdx = ReplicatePad(aSize, padSize, direction);
end
b = a(aIdx{:});


%%%
%%% CircularPad
%%%
function idx = CircularPad(aSize, padSize, direction)

numDims = numel(padSize);

% Form index vectors to subsasgn input array into output array.
% Also compute the size of the output array.
idx   = cell(1,numDims);
for k = 1:numDims
    M = aSize(k);
    dimNums = uint32(1:M);
    p = padSize(k);
    
    switch direction
        case 'pre'
            idx{k}   = dimNums(mod(-p:M-1, M) + 1);
            
        case 'post'
            idx{k}   = dimNums(mod(0:M+p-1, M) + 1);
            
        case 'both'
            idx{k}   = dimNums(mod(-p:M+p-1, M) + 1);
            
    end
end


%%%
%%% SymmetricPad
%%%
function idx = SymmetricPad(aSize, padSize, direction)

numDims = numel(padSize);

% Form index vectors to subsasgn input array into output array.
% Also compute the size of the output array.
idx   = cell(1,numDims);
for k = 1:numDims
    M = aSize(k);
    dimNums = uint32([1:M M:-1:1]);
    p = padSize(k);
    
    switch direction
        case 'pre'
            idx{k}   = dimNums(mod(-p:M-1, 2*M) + 1);
            
        case 'post'
            idx{k}   = dimNums(mod(0:M+p-1, 2*M) + 1);
            
        case 'both'
            idx{k}   = dimNums(mod(-p:M+p-1, 2*M) + 1);
    end
end


%%%
%%% ReplicatePad
%%%
function idx = ReplicatePad(aSize, padSize, direction)

numDims = numel(padSize);

% Form index vectors to subsasgn input array into output array.
% Also compute the size of the output array.
idx   = cell(1,numDims);
for k = 1:numDims
    M = aSize(k);
    p = padSize(k);
    onesVector = uint32(ones(1,p));
    
    switch direction
        case 'pre'
            idx{k}   = [onesVector 1:M];
            
        case 'post'
            idx{k}   = [1:M M*onesVector];
            
        case 'both'
            idx{k}   = [onesVector 1:M M*onesVector];
    end
end

