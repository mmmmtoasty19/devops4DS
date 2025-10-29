# Base Image
FROM python:3.12

# Install UV
COPY --from=ghcr.io/astral-sh/uv:latest /uv /usr/local/bin/uv

# create directory in container for vetiver files
WORKDIR /vetiver

# copy dependency files
COPY pyproject.toml uv.lock /vetiver/

# install dependencies using uv
RUN uv sync --frozen --no-dev

# copy app file
COPY run_api.py /vetiver/app/run_api.py

# expose port
EXPOSE 8080

# run vetiver API
CMD ["uv", "run", "uvicorn", "app.run_api:app", "--host", "0.0.0.0", "--port", "8080"]