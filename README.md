# roosts
UM roost analysis

Analysis of agreement bewteen field validation data collected on 17/03/2015 and roost shapefile created from eCognition software.

# Methodology:

# Roost validation analysis crown pts

eCog shapes are matched to field validation crowns and subset made

Subset is converted to points

"Near" is run in ArcGIS between field val crown pts and subsetted crown points

Field val pts "within" subset crown points are converted to neg values

.txt inported to r, summary calculated on dist to crown.

Crown Score is a sum of these positive and negative values (aiming for 0)

# eCog Rules

Variations between eCog datasets comes down to iterations during pixel growing

_no equates to no iterations or buffer at completion

ORIG equates to 5 iterations and 1 pixel buffer at completion

10 equates to 10 iterations and 1 pixel buffer at completion

