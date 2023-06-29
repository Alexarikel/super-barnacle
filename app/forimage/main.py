from fastapi.responses import HTMLResponse
from fastapi import FastAPI, Request
from fastapi.templating import Jinja2Templates
from fastapi import Form
from pydantic import BaseModel
import os

app = FastAPI()

templates = Jinja2Templates(directory="templates")

@app.get("/form/", response_class=HTMLResponse)
async def form(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

class Patient(BaseModel):
    doctor:str
    department:str
    first_name:str
    last_name:str
    age:str
    cost:int

@app.post("/submit/", response_model=Patient)
async def submit(doctor: str = Form(...), department: str = Form(...), first_name: str = Form(...), last_name: str = Form(...), age: str = Form(...), cost: int = Form(...)):
    obj = Patient(doctor=doctor, department=department, first_name=first_name, last_name=last_name, age=age, cost=cost)
    return obj
