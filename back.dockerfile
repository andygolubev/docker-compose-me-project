# Build image
FROM python:3.10.11-slim AS build

RUN apt-get update && \
    apt-get install --no-install-suggests --no-install-recommends --yes python3-venv gcc libpython3-dev && \
    python3 -m venv /venv

ENV PATH="/venv/bin:$PATH"

COPY backend/requirements.txt /requirements.txt

RUN pip install --upgrade pip setuptools wheel
RUN pip install --disable-pip-version-check -r /requirements.txt
RUN pip install --disable-pip-version-check fastDamerauLevenshtein

# Run image
FROM python:3.10.11-slim
EXPOSE 5000
COPY backend/* .
COPY --from=build /venv /venv
ENV PATH="/venv/bin:$PATH"

ENTRYPOINT ["python3", "Api.py"]
