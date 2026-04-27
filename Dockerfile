FROM frappe/erpnext:v15.85.0

USER root

# Copy your custom app into the image
COPY --chown=frappe:frappe ./apps/attendance_app /home/frappe/frappe-bench/apps/attendance_app

# Replace the core Frappe 404 page with your custom one
COPY --chown=frappe:frappe ./apps/attendance_app/attendance_app/www/404.html /home/frappe/frappe-bench/apps/frappe/frappe/www/404.html

# Copy HRMS at specific commit
COPY --chown=frappe:frappe ./apps/hrms /home/frappe/frappe-bench/apps/hrms

USER frappe

# Install the apps using pip (pyproject.toml / editable installs)
RUN cd /home/frappe/frappe-bench && \
    /home/frappe/frappe-bench/env/bin/pip install --no-cache-dir -e ./apps/attendance_app && \
    /home/frappe/frappe-bench/env/bin/pip install --no-cache-dir -e ./apps/hrms
