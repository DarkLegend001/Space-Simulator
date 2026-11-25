# Instructions
The interface is fairly simple, right click and drag rotates the camera, scroll wheel zooms in and out, and middle mouse drag pans the camera. Alternatively, WASD controls with C and space for vertical movement and Q and E to roll the camera can be used, along with arrow keys to rotate the camera. T toggles a precision mode to slow the movement of the camera with the keys.

Dark blue lines indicate previous positions on the planets, and light blue lines indicate a prediction of where they will be.

Clicking on a planet brings up an information panel about it and the option to follow the planet. Following the planet causes the reference frame to shift to be relative to that planet, so the positions and velocities, as well as the paths of other planets are now relative and the planet that is being followed appears stationary. When a planet has been selected as a reference frame, the information panel can display the orbital parameters of other planets relative to it, which is often more useful than positions and velocities.

There is a settings menu in the lower left corner, which can control various aspects of the simulation such as the speed, the timestep, and the predicted and stored paths. Additionally, the background and dynamic lighting can be disabled to allow for easier viewing of the simulation. To reset and change the simulation's planets, press escape. This resets the simulation and bring up a menu to edit the parameters of existing planets, delete planets, or add new planets. Scientific notation such as 1.7e15 can be used. Some values such as position and mass affect the simulation, and others such as light and color only affect the way it is displayed. A texture will overwrite a color, and textures will not be lit by the light source of the planet they are on. Textures can be loaded from the assets folder, and if a file is not found then the simulation will use the color instead. On the first run of the simulation, the planets will be populated from the presets.txt file found in the data folder. The presets file initially supplied contains the solar system out to Mars.

# Screenshots
A top down view of the demo solar system.
<img width="1917" height="1105" alt="image" src="https://github.com/user-attachments/assets/c2d22305-7b36-44ef-b9af-b69ffaf367e0" />

Following the earth, the moon has a relative path.
<img width="1917" height="1105" alt="image" src="https://github.com/user-attachments/assets/0bc94af5-4781-4b31-9dd3-954a71dd7609" />

The orbital parameters of Mars relative to the Sun.
<img width="1917" height="1105" alt="image" src="https://github.com/user-attachments/assets/ffac3a35-65c2-4030-9ec4-6025ecc0b3b5" />

The settings menu with background and dynamic lighting disabled.
<img width="1917" height="1105" alt="image" src="https://github.com/user-attachments/assets/fa84a84c-8f69-48e6-a5e9-7a4b198638bf" />

The default planets in the simulation menu.
<img width="1917" height="1105" alt="image" src="https://github.com/user-attachments/assets/221695dc-bd8e-42b7-8e44-94c96d37e9ee" />
