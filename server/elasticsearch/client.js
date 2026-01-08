const { Client } = require("@elastic/elasticsearch");

console.log(process.env.ELASTIC_URL);
const client = new Client({
  node: process.env.ELASTIC_URL,
});

client
  .ping()
  .then(() => console.log("✅ Connected to Elasticsearch"))
  .catch((err) => console.error("❌ Elasticsearch connection failed", err));

module.exports = client;
