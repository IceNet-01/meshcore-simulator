# MeshCore Network Simulator

A web-based visual simulator for [MeshCore](https://meshcore.co.nz/) mesh networks, providing an easy-to-use graphical interface for network planning and message propagation simulation.

> **ALPHA SOFTWARE** - This project is under rapid development. Features may break, change, or behave unexpectedly.

![Status](https://img.shields.io/badge/status-alpha-orange)
![License](https://img.shields.io/badge/license-MIT-blue)

## About MeshCore

MeshCore is a mesh networking protocol that differs from traditional flood-based approaches:

- **Path-based Routing** - Messages follow cached routes rather than flooding
- **Node Roles**:
  - **Companion** - End-user device, receives but doesn't forward
  - **Repeater** - Forwards packets through the mesh
  - **Room Server** - Stores and forwards messages, acts as a message hub
- **Up to 64 Hops** - Extended range compared to other protocols
- **Route Caching** - Learned routes are cached for efficient delivery

## Features

### Visual Network Design
- **Interactive Map Canvas** - OpenStreetMap background with drag-to-position nodes
- **Click-to-Add Nodes** - Double-click anywhere to place nodes
- **Real-time Link Quality** - See RSSI, SNR, and signal quality between nodes
- **Network Topology View** - Visualize all connections and coverage

### MeshCore Simulation
- **Path-based Message Routing** - See how DMs find optimal paths
- **Route Caching Visualization** - Track cached routes count
- **Broadcast with Selective Relay** - Only Repeaters/Room Servers forward broadcasts
- **Traceroute** - Discover network paths with detailed hop information
- **Animated Packets** - Visual packets travel between nodes

### Node Configuration
- **MeshCore Roles** - Companion, Repeater, Room Server
- **Antenna Settings** - Height and gain configuration
- **Hop Limit Control** - Up to 64 hops per message
- **Drag to Reposition** - Move nodes and see coverage changes

### Path Loss Models
Choose from 7 propagation models:
| Model | Best For |
|-------|----------|
| Log-distance | Generic calculations |
| Okumura-Hata (small cities) | Urban with low buildings |
| Okumura-Hata (metropolitan) | Dense urban areas |
| Okumura-Hata (suburban) | Residential areas |
| Okumura-Hata (rural) | Open countryside |
| 3GPP (suburban macro) | Mixed suburban |
| 3GPP (metro macro) | City centers |

## Quick Start

### Option 1: Run Locally

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app.py
```

Then open http://localhost:4000 in your browser.

### Option 2: Docker

```bash
docker-compose up -d
```

Then open http://localhost:4000 in your browser.

## Usage

### Adding Nodes
1. **Double-click on map** - Add node at that location
2. **Use the form** - Enter exact coordinates in the left panel
3. **Configure** - Set role, hop limit, antenna gain, and height

### Running Simulations
1. Add at least 2 nodes to the network
2. Select source/destination in the Commands panel
3. Click **Send Broadcast**, **Send DM**, or **Run Traceroute**
4. Watch the animated visualization on the map
5. Check the Message Log for detailed results

### Understanding Results
- **Cyan packets** - Broadcast messages
- **Green packets** - Direct messages (using cached routes)
- **Yellow packets** - Route discovery/Traceroute probes
- **Green rings** - Nodes that received the message
- **Red X** - Nodes that couldn't receive
- **H1, H2, etc.** - Hop count labels

### Route Cache
- Routes are automatically cached when discovered
- Use "Clear Routes" to reset the cache
- Cached routes are used for subsequent DMs to the same destination

## API Reference

### REST Endpoints

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | `/api/config` | Get simulator configuration |
| POST | `/api/config` | Update configuration |
| GET | `/api/nodes` | List all nodes |
| POST | `/api/nodes` | Add a new node |
| PUT | `/api/nodes/<id>` | Update a node |
| DELETE | `/api/nodes/<id>` | Delete a node |
| POST | `/api/nodes/clear` | Remove all nodes |
| POST | `/api/routes/clear` | Clear route cache |
| GET | `/api/topology` | Get network topology with links |
| GET | `/api/link/<id1>/<id2>` | Get link quality between two nodes |
| GET | `/api/export/yaml` | Export node config as YAML |
| POST | `/api/import/yaml` | Import node config from YAML |

### WebSocket Events

| Event | Direction | Description |
|-------|-----------|-------------|
| `connect` | Client -> Server | Connection established |
| `node_added` | Server -> Client | New node added |
| `node_updated` | Server -> Client | Node configuration changed |
| `node_removed` | Server -> Client | Node deleted |
| `send_command` | Client -> Server | Execute simulator command |
| `command_response` | Server -> Client | Command result with simulation data |

## Keyboard & Mouse Controls

- **Double-click canvas** - Add node at location
- **Click node** - Select node
- **Shift+Click node** - Multi-select nodes
- **Drag node** - Reposition node
- **Drag empty space** - Pan the map
- **Scroll wheel** - Zoom in/out
- **Fit button** - Auto-zoom to show all nodes

## MeshCore vs Meshtastic

| Feature | MeshCore | Meshtastic |
|---------|----------|------------|
| Routing | Path-based | Flood |
| Max Hops | 64 | 7 |
| Route Caching | Yes | No |
| Node Roles | Companion, Repeater, Room Server | Client, Router, etc. |
| Broadcast | Only relays forward | All nodes forward |

## License

MIT License

## Credits

- [MeshCore](https://meshcore.co.nz/) - The mesh networking protocol
- [OpenStreetMap](https://www.openstreetmap.org/) - Map tiles

## Disclaimer

This is an independent project and is not officially affiliated with or endorsed by the MeshCore project. Use simulation results as guidance only - real-world performance will vary based on terrain, obstacles, interference, and other factors.
