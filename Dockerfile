# Use an official Python runtime as a parent image
FROM python:3.11.6-bookworm

# Set up poetry
RUN pip install --upgrade pip
RUN pip install "poetry==1.7.0"
RUN poetry config virtualenvs.create false
# ENV POETRY_NO_INTERACTION=1 \
#     POETRY_VIRTUALENVS_IN_PROJECT=1 \
#     POETRY_VIRTUALENVS_CREATE=1 \
#     POETRY_CACHE_DIR=/tmp/poetry_cache
ENV POETRY_CACHE_DIR=/tmp/poetry_cache

RUN apt-get update
# Need to get HDF5 library for PyTables
RUN apt-get install --yes libhdf5-serial-dev
# Need to get libgl1 for PyVista
RUN apt-get install --yes libgl1


# Create app directory
RUN mkdir /app

# Move subdirectories needed for install into the app directory
# Doing these separately for now to try to take advantage of build caching?
RUN mkdir /app/networkframe
COPY ./networkframe /app/networkframe

# Avoiding copying other random files that might have changed
RUN mkdir /app/skedits
COPY ./skedits/pyproject.toml /app/skedits
COPY ./skedits/poetry.lock /app/skedits
# Now use poetry to install 
WORKDIR /app/skedits

RUN poetry install --only main --no-root && rm -rf $POETRY_CACHE_DIR

# Now install the local package
RUN mkdir /app/skedits/pkg
COPY ./skedits/pkg /app/skedits/pkg
RUN pip install -e ./pkg

# Run! 
WORKDIR /app
COPY run_jobs.py /app
ENV SKEDITS_USE_CLOUD True
ENV SKEDITS_RECOMPUTE False
ENV LAZYCLOUD_USE_CLOUD True
ENV LAZYCLOUD_RECOMPUTE False
CMD ["python", "run_jobs.py"]