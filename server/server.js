const express = require("express");
const cors = require("cors");
require("dotenv").config();

const client = require("./elasticsearch/client");

const app = express();

const port = process.env.PORT;

const data = require("./data/retrieveAndIngestData");

app.use("/ingest-data", data);

app.use(cors());
app.get("/results", (req, res) => {
  const passedType = req.query.type;
  const passedMag = req.query.mag;
  const passedLocation = req.query.location;
  const passedDateRange = req.query.dateRange;
  const passedSortOption = req.query.sortOption;
  async function sendESRequest() {
    const body = await client.search({
      index: "earthquakes",
      body: {
        sort: [
          {
            mag: {
              order: passedSortOption,
            },
          },
        ],
        size: 30,
        query: {
          bool: {
            filter: [
              {
                term: { type: passedType },
              },
              {
                range: {
                  mag: {
                    gte: passedMag,
                  },
                },
              },
              {
                match: { place: passedLocation },
              },
              {
                range: {
                  "@timestamp": {
                    gte: `now-${passedDateRange}d/d`,
                    lt: "now/d",
                  },
                },
              },
            ],
          },
        },
      },
    });
    res.json(body.hits.hits);
  }

  sendESRequest();
});

app.listen(port, () =>
  console.log(`Server listening at http://localhost:${port}`),
);
