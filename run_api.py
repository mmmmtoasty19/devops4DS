# If model has changed make sure to rerun/render model-py.qmd
# run this script from the command line uv run run_api.py

from pins import board_folder
from vetiver import VetiverAPI, VetiverModel

# Load the model from the pin
model_board = board_folder("/data/model", allow_pickle_read=True)
v = VetiverModel.from_pin(model_board, "penguin_model")

# Create API
vetiver_api = VetiverAPI(v, check_prototype=True)
app = vetiver_api.app  # Extract the FastAPI app for uvicorn

# When running locally, uncomment this:
# vetiver_api.run(port=8080)
