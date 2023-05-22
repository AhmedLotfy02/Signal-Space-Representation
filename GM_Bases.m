function [phi_1, phi_2] = GM_Bases(s1, s2)
  
    n=length(s1);
    % Calculate the first basis function
    phi_1 = s1 / norm(s1 / (n .^ 0.5));
   
    % Calculate the projection of s_2 onto phi_1
    projection = dot(s2 , phi_1) * phi_1;
    projection = projection / n;
    
    % Calculate the second basis function
    phi_2 = s2 - projection;
    phi_2 = phi_2 / norm(phi_2/(n.^0.5));
 
end
