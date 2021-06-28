const express = require("express");
const cookieParser = require("cookie-parser");
const cors = require("cors");
const morgan = require("morgan");
const app = express();
const helmet = require("helmet");
const os = require("os");

const hs = os.hostname();

app.use(express.json());
app.use(cookieParser());
app.use(morgan("combined"));
app.use(cors());
app.use(helmet());

app.get("/", (req, res) => res.send({ server: hs, status: 200, platform: "node" }));

const port = process.env.PORT || 4000;
app.listen(port, () => {
  console.log(`listening at http://localhost:${port}`);
});
