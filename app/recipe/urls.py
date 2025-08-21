"""
URL patterns for the recipe app.
"""

from django.urls import path, include
from rest_framework.routers import DefaultRouter
from recipe import views

# Create a router and register the RecipeViewSet
router = DefaultRouter()
router.register('recipes', views.RecipeViewSet)
router.register('tags', views.TagViewSet)
router.register('ingredients', views.IngredientViewSet)

# Define the URL patterns for the recipe app
app_name = 'recipe'

urlpatterns = [
    path('', include(router.urls)),
]