clc
clear
close all
fprintf('Please wait as the images are being created...\n');
%% Load data %%
load('hw2.mat');

%% Step 0 -Initial position 
% 0.1 Render object with render_object
I0 = render_object(V,F,C,M,N,H,W,w, cv, ck, cu);

% Save result
imwrite(I0, '0.jpg');

%% Step 0.5 - Create a transformation matrix
%Create 3 transformation matrices for simplicity
trans1 = transformation_matrix;
trans2 = transformation_matrix;
trans3 = transformation_matrix;
%% Step 1 - Translate the transformation matrix by t1
% 1.1 Apply translation
%Transposing the arrays is necessary for the functions to work

V=transpose(V);

%Translate
trans1.translate(t1);
V_t1 = affine_transform(V,trans1);

V_t1 = transpose(V_t1);
% 1.2 Render object with render_object
I1 = render_object(V_t1,F,C,M,N,H,W,w, cv, ck, cu);
% Save result
imwrite(I1, '1.jpg');

%% Step 2 - Rotate the transformation matrix by theta around given axis
% 2.1 Apply rotation
%Transposing the arrays is necessary for the functions to work

V_t1=transpose(V_t1);

%Rotation
trans2.rotate(theta,g);
V_t1_r = affine_transform(V_t1,trans2);

V_t1_r = transpose(V_t1_r);

% 2.2 Render object with render_object
I2 = render_object(V_t1_r,F,C,M,N,H,W,w, cv, ck, cu);
% Save result
imwrite(I2, '2.jpg');

%% Step 3 - Translate the transformation matrix back
% 3.1 Apply translation
%Transposing the arrays is necessary for the functions to work

V_t1_r=transpose(V_t1_r);

%Translate
trans3.translate(t2);
V_t1_r_t2 = affine_transform(V_t1_r,trans3);

V_t1_r_t2 = transpose(V_t1_r_t2);

% 3.2 Render object with render_object
I3 = render_object(V_t1_r_t2,F,C,M,N,H,W,w, cv, ck, cu);
% Save result
imwrite(I3, '3.jpg');
fprintf('Done! Please check your directory for images 0,1,2 and 3\n');