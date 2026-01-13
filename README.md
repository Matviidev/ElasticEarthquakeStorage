# ElasticEarthquakeStorage

A full-stack web application for searching and analyzing earthquake data using Elasticsearch. The application retrieves earthquake data from the USGS (United States Geological Survey) API, indexes it in Elasticsearch, and provides an intuitive web interface for filtering and searching earthquakes based on various criteria.

## 🌟 Features

- **Real-time Data Ingestion**: Fetches earthquake data from USGS API
- **Advanced Search**: Filter earthquakes by:
  - Type (Earthquake, Quarry Blast, Ice Quake, Explosion)
  - Magnitude (2.5+, 5.5+, 6.1+, 7+, 8+)
  - Location (city, state, country)
  - Date Range (Past 7, 14, 21, or 30 days)
  - Sort by magnitude (ascending/descending)
- **Elasticsearch Integration**: Efficient indexing and querying using Elasticsearch
- **Docker Support**: Easy setup with Docker Compose
- **Modern UI**: Clean React-based frontend with responsive design

## 🛠️ Tech Stack

### Backend

- **Node.js** - Runtime environment
- **Express** - Web framework
- **Elasticsearch** - Search and analytics engine
- **Axios** - HTTP client for API requests

### Frontend

- **React** - UI library
- **Vite** - Build tool and dev server
- **Axios** - HTTP client

### Infrastructure

- **Docker** - Containerization
- **Docker Compose** - Multi-container orchestration

## 📋 Prerequisites

- Node.js (v22 or higher)
- Docker and Docker Compose
- npm or yarn

## 🚀 Getting Started

### Option 1: Using Docker Compose (Recommended)

1. **Clone the repository**

   ```bash
   git clone https://github.com/Matviidev/ElasticEarthquakeStorage.git
   cd ElasticEarthquakeStorage
   ```

2. **Navigate to the server directory**

   ```bash
   cd server
   ```

3. **Create a `.env` file** in the `server` directory:

   ```env
   PORT=3000
   ELASTIC_URL=http://elasticsearch:9200
   ```

4. **Start the services**

   ```bash
   docker-compose up
   ```

   This will:
   - Start Elasticsearch on port 9200
   - Build and start the Node.js application on port 3000
   - Initialize the Elasticsearch index and pipeline

5. **In a new terminal, start the client**

   ```bash
   cd client
   npm install
   npm run dev
   ```

6. **Access the application**
   - Frontend: http://localhost:5173 (or the port Vite assigns)
   - Backend API: http://localhost:3000
   - Elasticsearch: http://localhost:9200

### Option 2: Local Development

1. **Start Elasticsearch**

   ```bash
   cd server
   docker-compose up elasticsearch
   ```

2. **Set up environment variables**
   Create a `.env` file in the `server` directory:

   ```env
   PORT=3000
   ELASTIC_URL=http://localhost:9200
   ```

3. **Initialize Elasticsearch**

   ```bash
   cd server
   chmod +x init-es.sh
   ./init-es.sh
   ```

4. **Install server dependencies and start**

   ```bash
   cd server
   npm install
   npm start
   ```

5. **Install client dependencies and start**
   ```bash
   cd client
   npm install
   npm run dev
   ```

## 📊 Data Ingestion

To ingest earthquake data from the USGS API:

1. Make sure the server is running
2. Visit: `http://localhost:3000/ingest-data/earthquakes`

This will:

- Fetch earthquake data from the USGS API
- Process the data through the Elasticsearch ingest pipeline
- Index the data into the `earthquakes` index

## 🔍 API Endpoints

### Search Earthquakes

```
GET /results?type={type}&mag={magnitude}&location={location}&dateRange={days}&sortOption={asc|desc}
```

**Query Parameters:**

- `type` - Earthquake type (earthquake, quarry blast, ice quake, explosion)
- `mag` - Minimum magnitude (e.g., 2.5, 5.5, 6.1, 7, 8)
- `location` - Location search term (city, state, country)
- `dateRange` - Number of days (7, 14, 21, 30)
- `sortOption` - Sort order (asc, desc)

**Example:**

```bash
curl "http://localhost:3000/results?type=earthquake&mag=5.5&location=California&dateRange=30&sortOption=desc"
```

### Ingest Data

```
GET /ingest-data/earthquakes
```

Fetches and indexes earthquake data from the USGS API.

## 🌐 Environment Variables

### Server

- `PORT` - Server port (default: 3000)
- `ELASTIC_URL` - Elasticsearch connection URL

## 🐳 Docker Services

- **elasticsearch**: Elasticsearch 8.12.0 instance
- **ks-app**: Node.js application container
