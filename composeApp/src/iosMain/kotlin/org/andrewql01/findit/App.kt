package org.andrewql01.findit

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Home
import androidx.compose.material.icons.filled.Place
import androidx.compose.material.icons.filled.Settings
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.NavigationBar
import androidx.compose.material3.NavigationBarItem
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.vector.ImageVector
import org.andrewql01.findit.ui.home.HomeView
import org.andrewql01.findit.ui.maps.MapView
import org.andrewql01.findit.ui.settings.SettingsView

@Composable
fun App() {
    MaterialTheme {
        var selectedTab by remember { mutableStateOf(Tab.HOME) }

        Scaffold (
            bottomBar = {
                NavigationBar {
                    Tab.entries.forEach { tab ->
                        NavigationBarItem (
                            icon = { Icon(tab.icon, contentDescription = null) },
                            label = { Text(tab.label) },
                            selected = selectedTab == tab,
                            onClick = { selectedTab = tab }
                        )
                    }
                }
            }
        ) { paddingValues ->
            Column(
                modifier = Modifier.padding(paddingValues).fillMaxSize(),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.Center
            ) {
                selectedTab.screen()
            }
        }
    }
}


enum class Tab (val label: String, val icon: ImageVector) {
    HOME("Home", Icons.Default.Home),
    MAPS("Maps", Icons.Default.Place),
    SETTINGS("Settings", Icons.Default.Settings)
}

@Composable
fun Tab.screen() {
    when(this) {
        Tab.HOME -> HomeView()
        Tab.MAPS -> MapView()
        Tab.SETTINGS -> SettingsView()
    }
}