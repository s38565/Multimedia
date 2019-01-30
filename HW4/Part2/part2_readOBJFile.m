clear all; close all; clc; 
addpath('data');

%% Read OBJ file
obj = readObj('trump.obj');
tval = display_obj(obj,'tumpLPcolors.png');
vertex = obj.v;
faces = obj.f.v;
colors = tval;

%trisurf(faces,vertex(:,1),vertex(:,2),vertex(:,3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
%xlabel('X'); ylabel('Y'); zlabel('Z');

%% Move the Center of OBJ to (0, 0, 0)
center = [(max(vertex(:, 1))+min(vertex(:, 1)))/2, (max(vertex(:, 2))+min(vertex(:, 2)))/2, (max(vertex(:, 3))+min(vertex(:, 3)))/2];
vertex = [vertex(:,1) - center(1), vertex(:,2) - center(2), vertex(:,3) - center(3)];

%trisurf(faces,vertex(:,1) - center(1), vertex(:,2) - center(2), vertex(:,3) - center(3),'FaceVertexCData', colors,'FaceColor','interp', 'EdgeAlpha', 0);
%xlabel('X'); ylabel('Y'); zlabel('Z');


%% Generate a HSV Hexagonal Prism onto the same world space as trump.obj, and then do some transformation
% (Hint) You can try to combine 2 objects' vertices, faces, colors together

% define 
top_vertices = [];
top_vertices_index = [];
bottom_Vertices = [];
botton_vertices_index = [];
top_colors = [];
bottom_colors = [];
faces_hex = [];
faceVert_l = [];
center_top = [0, 0.5, 0];
center_down = [0, -0.5, 0];

% size record
s = size(vertex, 1);

numofVert = 6;
vertsPolarAngle = linspace(0, 2*pi, numofVert + 1);
vertsX = cos(vertsPolarAngle);
vertsZ = sin(vertsPolarAngle);



% vertices of top and bottom
for i = 1:numofVert
    top_vertices = [top_vertices; vertsX(i), 0.5, vertsZ(i)];
    bottom_Vertices = [bottom_Vertices; vertsX(i), -0.5, vertsZ(i)];
end


top_vertices = [top_vertices; center_top];
bottom_Vertices = [bottom_Vertices; center_down];
verts = [top_vertices; bottom_Vertices];

center_top_index = 7; % 7
center_down_index = 14; % 14

for i = 1:numofVert
    top_vertices_index = [top_vertices_index; i]; % index = 1~6
end

top_vertices_index = [top_vertices_index; center_top_index];

for i = numofVert+2 : numofVert+7
    botton_vertices_index = [botton_vertices_index; i]; % index = 8~13 
end

botton_vertices_index = [botton_vertices_index; center_down_index];

for i = 1:numofVert
    top_colors = [top_colors; hsv2rgb([vertsPolarAngle(i) / (2 * pi), 1, 1])];
    bottom_colors = [bottom_colors; hsv2rgb([vertsPolarAngle(i) / (2 * pi), 1, 0])];
end

myColor = hsv2rgb([0, 0, 1]);
top_colors = [top_colors; myColor]; 
myColor1 = hsv2rgb([0, 0, 0]);
bottom_colors = [bottom_colors; myColor1]; 
vertColors = [top_colors; bottom_colors];

% Top
for i = 1:numofVert-1
    faces_hex = [faces_hex; i, i + 1, numofVert + 1];
end
faces_hex = [faces_hex; numofVert, 1, numofVert + 1];

% Side
for i = 1:numofVert
    if i + 1 <= numofVert
        val = i + 1;
    else
        val = 1;
    end
    faceVert_l = [faceVert_l; top_vertices_index(i), top_vertices_index(val), botton_vertices_index(i); top_vertices_index(val), botton_vertices_index(i), botton_vertices_index(val)];
    faces_hex = [faces_hex; top_vertices_index(i), top_vertices_index(val), botton_vertices_index(i); top_vertices_index(val), botton_vertices_index(i), botton_vertices_index(val)];
end

% Bottom
for i = 1:numofVert
    if i ~= numofVert
        faces_hex = [faces_hex; i + numofVert + 1, i + 8, center_down_index];
    else
        faces_hex = [faces_hex; i + numofVert + 1, 8, center_down_index];
    end
end


s1 = size(verts,1);
faces = faces + s1;

% hexagonal prism
%trisurf(faces_hex, verts(:, 1), verts(:, 2), verts(:, 3), 'FaceVertexCData', vertColors, 'FaceColor', 'interp', 'EdgeAlpha', 0);
%xlabel('X'); ylabel('Y'); zlabel('Z');

v(:, 1) = verts(:,1);
v(:, 2) = verts(:,2) - 1.4;
v(:, 3) = verts(:,3);

face = [faces_hex; faces];
vert = [v; vertex];
color = [vertColors; colors];

% (d)
trisurf(face, vert(:,1),vert(:,2),vert(:,3),'FaceVertexCData', color,'FaceColor','interp', 'EdgeAlpha', 0 );
xlabel('X'); ylabel('Y'); zlabel('Z');
title('(2d). both models');

%% Lighting (You may need to modify the lighting here)

% position light
figure;
trisurf(face, vert(:,1),vert(:,2),vert(:,3),'FaceVertexCData', color,'FaceColor','interp', 'EdgeAlpha', 0 );
light('Position',[0.0,0.0,5.0], 'Style', 'local');
lighting phong;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('(2e). position light');

% directional light
figure;
trisurf(face, vert(:,1),vert(:,2),vert(:,3),'FaceVertexCData', color,'FaceColor','interp', 'EdgeAlpha', 0 );
light('Style', 'infinite');
lighting phong;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('(2e). directional light');

% output
figure;
trisurf(face, vert(:,1),vert(:,2),vert(:,3),'FaceVertexCData', color,'FaceColor','interp', 'EdgeAlpha', 0 );
material([1.0 0.0 0.0]);
light('Position',[0.0,0.0,4.0],'Style', 'local');
lighting phong;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('(ka , kd , ks) = (1.0, 0.0, 0.0)');

figure;
trisurf(face, vert(:,1),vert(:,2),vert(:,3),'FaceVertexCData', color,'FaceColor','interp', 'EdgeAlpha', 0 );
material([0.1 1.0 0.0]);
light('Position',[0.0,0.0,4.0],'Style', 'local');
lighting phong;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('(ka , kd , ks) = (0.1, 1.0, 0.0)');

figure;
trisurf(face, vert(:,1),vert(:,2),vert(:,3),'FaceVertexCData', color,'FaceColor','interp', 'EdgeAlpha', 0 );
material([0.1 0.1 1.0]);
light('Position',[0.0,0.0,4.0],'Style', 'local');
lighting phong;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('(ka , kd , ks) = (0.1, 0.1, 1.0)');

figure;
trisurf(face, vert(:,1),vert(:,2),vert(:,3),'FaceVertexCData', color,'FaceColor','interp', 'EdgeAlpha', 0 );
material([0.1 0.8 1.0]);
light('Position',[0.0,0.0,4.0],'Style', 'local');
lighting phong;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('(ka , kd , ks) = (0.1, 0.8, 1.0)');