package org.andrewql01.findit.ui.maps

import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Modifier
import androidx.compose.ui.viewinterop.UIKitView
import kotlinx.cinterop.ExperimentalForeignApi
import platform.CoreLocation.CLLocationCoordinate2DMake
import platform.MapKit.MKMapView


@OptIn(ExperimentalForeignApi::class)
@Composable
actual fun NativeMap(
    centerCoordinate: Coordinate,
    modifier: Modifier
) {
    val clLocation = remember(centerCoordinate) {
        CLLocationCoordinate2DMake(
            centerCoordinate.latitude,
            centerCoordinate.longitude
        )
    }
    UIKitView(
        modifier = Modifier.fillMaxSize(),
        factory = {
            MKMapView().apply {
                setZoomEnabled(true)
                setScrollEnabled(true)
            }
        },
        update = { mapView ->
            mapView.setCenterCoordinate(clLocation, animated = true)
        }
    )
}