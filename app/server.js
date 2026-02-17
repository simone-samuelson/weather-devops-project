const express = require('express');
const axios = require('axios');
const app = express();
const PORT = process.env.PORT || 3000;
const API_KEY = process.env.OPENWEATHER_API_KEY;

app.get('/', (req, res) => {
  res.send('<html><head><title>Weather Dashboard</title></head><body><h1>Weather Dashboard</h1><input type="text" id="city" placeholder="Enter city name" /><button onclick="getWeather()">Get Weather</button><div id="weather"></div><script>async function getWeather(){const city=document.getElementById("city").value;if(!city){alert("Please enter a city");return;}const response=await fetch("/api/weather?city="+city);const data=await response.json();if(data.error){document.getElementById("weather").innerHTML="<p style=color:red>"+data.error+"</p>";}else{document.getElementById("weather").innerHTML="<h2>"+data.city+"</h2><p>Temp: "+data.temp+"C</p><p>Feels like: "+data.feels_like+"C</p><p>Weather: "+data.description+"</p><p>Humidity: "+data.humidity+"%</p><p>Wind: "+data.wind_speed+" m/s</p>";}}</script></body></html>');
});

app.get('/api/weather', async (req, res) => {
  const city = req.query.city;
  if (!city) return res.status(400).json({ error: 'City parameter is required' });
  if (!API_KEY) return res.status(500).json({ error: 'API key not configured' });
  try {
    const url = 'https://api.openweathermap.org/data/2.5/weather?q=' + city + '&appid=' + API_KEY + '&units=metric';
    const response = await axios.get(url);
    res.json({
      city: response.data.name,
      temp: response.data.main.temp,
      feels_like: response.data.main.feels_like,
      description: response.data.weather[0].description,
      humidity: response.data.main.humidity,
      wind_speed: response.data.wind.speed
    });
  } catch (error) {
    if (error.response && error.response.status === 404) {
      res.status(404).json({ error: 'City not found' });
    } else {
      res.status(500).json({ error: 'Failed to fetch weather data' });
    }
  }
});

app.get('/health', (req, res) => {
  res.status(200).json({ status: 'healthy' });
});

app.listen(PORT, () => {
  console.log('Weather dashboard running on port ' + PORT);
  console.log('API Key configured: ' + (API_KEY ? 'Yes' : 'No'));
});
