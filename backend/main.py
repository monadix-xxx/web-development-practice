from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI(
    title="Practice Store API",
    description="Минимальное API для учебной практики по backend-разработке.",
    version="1.0.0",
)


class Product(BaseModel):
    id: int
    name: str
    category: str
    price: int


PRODUCTS = [
    Product(id=1, name="Клавиатура", category="Периферия", price=5900),
    Product(id=2, name="Мышь", category="Периферия", price=2900),
    Product(id=3, name="USB-C хаб", category="Аксессуары", price=3500),
]


@app.get("/")
def root() -> dict[str, str]:
    return {"message": "Practice Store API is running"}


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok"}


@app.get("/products", response_model=list[Product])
def list_products() -> list[Product]:
    return PRODUCTS


@app.get("/products/{product_id}", response_model=Product)
def get_product(product_id: int) -> Product:
    for product in PRODUCTS:
        if product.id == product_id:
            return product
    raise HTTPException(status_code=404, detail="Product not found")
