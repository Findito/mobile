package org.andrewql01.findit.ui.maps

import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier

@Composable
fun MapView() {
    Box(modifier = Modifier.fillMaxSize()) {
        NativeMap(
            centerCoordinate = Coordinate(37.7749, -122.4194), // San Francisco
            modifier = Modifier.fillMaxSize()
        )
    }
}