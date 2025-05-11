package org.andrewql01.findit.ui.maps

import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

data class Coordinate(val latitude: Double, val longitude: Double)

@Composable
expect fun NativeMap(
    centerCoordinate: Coordinate,
    modifier: Modifier = Modifier
)