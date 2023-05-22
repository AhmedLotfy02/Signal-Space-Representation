function [v1, v2] = signal_space(s, phi1, phi2)
    % Check if s, phi1, and phi2 have the same length
    if length(s) ~= length(phi1) || length(s) ~= length(phi2)
        error('Input signals and bases functions must have the same length.');
    end
    
    % Calculate the projections (correlations) of s onto phi1 and phi2
    v1 = dot(s, phi1);
    v2 = dot(s, phi2);
    v1=v1/length(s);
    v2=v2/length(s);
end
