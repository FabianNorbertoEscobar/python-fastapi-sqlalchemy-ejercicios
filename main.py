from fastapi import FastAPI
import uvicorn
from app.db.database import Base, engine
from app.routers import user, auth, web

app = FastAPI()

# Crear tablas en la base de datos si no existen
Base.metadata.create_all(bind=engine)

app.include_router(user.router)
app.include_router(auth.router)
app.include_router(web.router)

if __name__ == "__main__":
    uvicorn.run("main:app", port=8000, reload=True)
