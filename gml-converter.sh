#!/bin/bash
WKT_C=""
GML='<gml:Polygon srsName="http://www.opengis.net/gml/srs/epsg.xml#4326" xmlns:gml="http://www.opengis.net/gml">   <gml:outerBoundaryIs>      <gml:LinearRing>         <gml:coordinates>29.073282,110.593719 29.480221,113.151863 27.857580,113.469070 27.447992,110.951752 29.073282,110.593719</gml:coordinates>      </gml:LinearRing>   </gml:outerBoundaryIs></gml:Polygon>'
#GML='<gml:Polygon srsName="http://www.opengis.net/gml/srs/epsg.xml#4326" xmlns:gml="http://www.opengis.net/gml"> <gml:outerBoundaryIs> <gml:LinearRing> <gml:coordinates>-7.325040571697505,-141.68622 -7.223980734847526,-141.66336 -7.075591383988536,-141.6298 -6.928165845702403,-141.5965 -6.968896745528448,-141.3758 -6.968588209905554,-141.37572 -6.96862819198569,-141.3755 -6.968370096055247,-141.37544 -6.968416817425211,-141.37518 -6.968219978208444,-141.37515 -6.968280032114795,-141.37482 -6.967909965418896,-141.37474 -6.967954825157316,-141.37448 -6.967940554967766,-141.37448 -6.967940739518604,-141.37448 -6.96780642389315,-141.37445 -6.967833152973337,-141.37431 -6.967609862859143,-141.37425 -6.967702508975961,-141.37375 -6.967312369214896,-141.37366 -6.967332199890836,-141.37355 -6.966985988947181,-141.37347 -6.967021301670114,-141.37328 -6.966747511481573,-141.37321 -6.966767199245404,-141.37311 -6.965480671002688,-141.37282 -7.008118140628137,-141.1401 -7.010286943199535,-141.1406 -7.010318622284114,-141.14044 -7.01047013131652,-141.14047 -7.050907498562074,-140.93605 -7.050813533909928,-140.93604 -7.050845791953425,-140.93587 -7.050693222318369,-140.93584 -7.050733680854519,-140.93564 -7.050626572047819,-140.93561 -7.050647983662826,-140.9355 -7.050590587466277,-140.93549 -7.050594520016613,-140.93547 -7.050254245884836,-140.9354 -7.050262796568596,-140.93535 -7.050073853918852,-140.9353 -7.050078479061976,-140.93529 -7.05007421212502,-140.93529 -7.050133917235294,-140.93498 -7.049831441182095,-140.9349 -7.049836163808217,-140.93489 -7.049504882622272,-140.93481 -7.049524888368239,-140.93471 -7.049405186316981,-140.93468 -7.049424418184812,-140.93459 -7.048371240220335,-140.93434 -7.05291980630223,-140.91162 -7.325744468031913,-140.91158 -7.325040571697505,-141.68622</gml:coordinates> </gml:LinearRing> </gml:outerBoundaryIs> </gml:Polygon>'
GML='<gml:Polygon srsName="http://www.opengis.net/gml/srs/epsg.xml#4326" xmlns:gml="http://www.opengis.net/gml"> <gml:outerBoundaryIs> <gml:LinearRing> <gml:coordinates>-17.966356,-179.053009 -17.427544,178.639374 -15.686904,179.077927 -16.218512,-178.633652 -17.966356,-179.053009</gml:coordinates> </gml:LinearRing> </gml:outerBoundaryIs> </gml:Polygon>'
GML='<gml:Polygon srsName="http://www.opengis.net/gml/srs/epsg.xml#4326" xmlns:gml="http://www.opengis.net/gml"> <gml:outerBoundaryIs> <gml:LinearRing> <gml:coordinates>-71.825974,171.667770 -69.444878,-179.412338 -72.155457,-170.672318 -74.922943,-179.853333 -71.825974,171.667770</gml:coordinates> </gml:LinearRing> </gml:outerBoundaryIs> </gml:Polygon>'
GML_C=$(echo "$GML" | sed -rn 's|.*<gml:coordinates>(.*)</gml:coordinates>.*|\1|p')
echo "Found coordinates: $GML_C"

WKT_P1=""
WKT_P2=""

IFS=' ' read -ra GML_POINTS <<< "$GML_C"
N_POINTS=$((${#GML_POINTS[@]}-1))
echo "found $N_POINTS points"
for p in "${GML_POINTS[@]}"
do :
    WKT_P=$(echo $p | awk -F"," '{print$2" "$1}')
    WKT_PA=$(echo $WKT_P | awk -F" " '{print$1}')
    
    if (( $(echo "$WKT_PA > 0" | bc -l) )); then
        WKT_P1="$WKT_P1,$WKT_P"
    else
        WKT_P2="$WKT_P2,$WKT_P"
    fi

    WKT_C="$WKT_C,$WKT_P"
done

WKT_P1=$(echo $WKT_P1 | sed 's/^,//')
echo "WKT_P1: $WKT_P1"
IFS=',' read -ra WKT_P1A <<< "$WKT_P1"

WKT_P2=$(echo $WKT_P2 | sed 's/^,//')
echo "WKT_P2: $WKT_P2"
IFS=',' read -ra WKT_P2A <<< "$WKT_P2"

echo "___________________________"

WKT_P1=""
WKT_P2=""
#se e maggiore di 2
# WKT_P1A+=("$(echo "${WKT_P1A[-1]}" | awk -F " " '{print "180.000000 "$2}')")
# WKT_P1A+=("$(echo "${WKT_P1A[0]}" | awk -F " " '{print "180.000000 "$2}')")

# for p in "${WKT_P1A[@]}"
# do :
#     WKT_P1="$WKT_P1,$p"
# done
# WKT_P1="$WKT_P1,${WKT_P1A[0]}"



WKT_P2A+=("$(echo "${WKT_P2A[(${#WKT_P2A[@]}-2)]}" | awk -F " " '{print "-180.000000 "$2}')")
WKT_P2A+=("$(echo "${WKT_P2A[0]}" | awk -F " " '{print "-180.000000 "$2}')")
for p in "${WKT_P2A[@]}"
do :
    WKT_P2="$WKT_P2,$p"
done
WKT_P2="$WKT_P2,${WKT_P2A[0]}"

#se e minore di 2
WKT_P1A+=("$(echo "${WKT_P2A[(${#WKT_P2A[@]}-3)]}" | awk -F " " '{print "180.000000 "$2}')")
WKT_P1A+=("$(echo "${WKT_P2A[0]}" | awk -F " " '{print "180.000000 "$2}')")
for p in "${WKT_P1A[@]}"
do :
    WKT_P1="$WKT_P1,$p"
done
WKT_P1="$WKT_P1,${WKT_P1A[0]}"

WKT_P1=$(echo $WKT_P1 | sed 's/^,//')
echo "WKT_P1: $WKT_P1"

WKT_P2=$(echo $WKT_P2 | sed 's/^,//')
echo "WKT_P2: $WKT_P2"

#WKT_C=$(echo $WKT_C | sed 's/^,//')
WKT_C=$(echo "MULTIPOLYGON( (($WKT_P1)),(($WKT_P2)) )")
echo $WKT_C