function CFPIplot(path)
    if nargin < 1
        path = 'data_matlab.csv';
    end

    [Sin, D, data, param] = csv2matlab(path);

    figure;
    for i = 1:size(Sin)
        temp = ones(size(D))*Sin(i);
        plot3(temp, D, transpose(data(i,:,3)), 'b');
        hold on
        plot3(temp, D, transpose(data(i,:,2)), 'r');
        hold on
    end
    
    surf(Sin, D, transpose(data(:,:,1)));
    colormap([0.5 0.5 0.5]);
    axis ij;
    xlabel('S_{in} [g/L]');
    ylabel('D [1/h]');
    zlabel('P [g/L]');
    title(['K_i = ' num2str(param(3)) ' [g/L]; \tau = ' num2str(param(6)) ' [h]']);
end

function [Sin, D, data, param] = csv2matlab(path)
    temp = csvread(path, 0, 0, [0 0 0 7]);
    paramSin = temp(1); paramD = temp(2); param = temp(3:8);
    
    D = transpose(csvread(path, 1, 0, [1 0 1 paramD-1]));
    Sin = csvread(path, 2, 0, [2 0 paramSin+1 0]);
    
    data = zeros(paramSin, paramD, 3);
    
    for i = 1:3
        for d = 1:paramD
            data(:, d, i) = csvread(path, 2+paramSin*(d-1), i, [2+paramSin*(d-1) i 1+paramSin*d i]);
        end
    end
end