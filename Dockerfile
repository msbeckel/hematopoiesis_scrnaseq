# Base R Shiny image
FROM msbeckel/scx:0.2.0

# Make a directory in the container
RUN mkdir /home/shiny-app

# Copy the Shiny app code
COPY example.r /home/shiny-app/make_scX.r

#
RUN chmod -R 755 /home/shiny-app/
RUN mkdir /data && chown shiny:shiny /data

# Expose the application portS
EXPOSE 9191

# Run the R Shiny app
CMD Rscript /home/shiny-app/make_scX.r