# Use an official Python runtime as a parent image
FROM python:3.11.6-bookworm

# Set up poetry
ENV POETRY_VERSION=1.7.0
RUN pip install --upgrade pip
RUN pip install "poetry==$POETRY_VERSION"
RUN poetry config virtualenvs.create false

# Need to get HDF5 library for PyTables
RUN apt-get update
RUN apt-get install --yes libhdf5-serial-dev

# Create app directory
RUN mkdir /app

# Move subdirectories needed for install into the app directory
# Doing these separately for now to try to take advantage of build caching
RUN mkdir /app/apical_classifier
COPY ./apical_classifier /app/apical_classifier

RUN mkdir /app/axon_id
COPY ./axon_id /app/axon_id

RUN mkdir /app/pcg_skel
COPY ./pcg_skel /app/pcg_skel

RUN mkdir /app/skeleton_plot
COPY ./skeleton_plot /app/skeleton_plot

RUN mkdir /app/neuropull
COPY ./neuropull /app/neuropull

# Avoiding copying other random files that might have changed
RUN mkdir /app/skedits
COPY ./skedits/pyproject.toml /app/skedits
COPY ./skedits/poetry.lock /app/skedits
RUN mkdir /app/skedits/pkg
COPY ./skedits/pkg /app/skedits/pkg

# Now use poetry to install 
WORKDIR /app/skedits
RUN poetry install --only main

# Run! 
WORKDIR /app
COPY run_jobs.py /app
ENV SKEDITS_USE_CLOUD True
ENV SKEDITS_RECOMPUTE False
CMD ["python", "run_jobs.py"]