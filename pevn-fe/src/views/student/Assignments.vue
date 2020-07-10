<template>
  <v-container class="text-center">
    <NavbarS :s_name="student.name" />
    <v-alert
      text
      v-model="alert.show"
      :type="alert.type"
      dismissible
      class="text-start"
    >{{alert.message}}</v-alert>
    <h1 class="font-weight-light">{{course.c_name}}</h1>
    <h2 class="font-weight-thin">{{course.c_description}}</h2>
    <v-row justify="center">
      <v-col md="9" sm="12">
        <v-simple-table fixed-header>
          <thead>
            <tr>
              <th class="text-center">Name</th>
              <th class="text-center">Description</th>
              <th class="text-center">File</th>
              <th class="text-center">Up delivery</th>
              <th class="text-center">Delivery</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="assignment in assignmentsList" :key="assignment.id_a">
              <td>{{assignment.a_name}}</td>
              <td>{{assignment.a_description}}</td>
              <td>
                <v-icon @click="open(assignment.a_file)">mdi-file-pdf</v-icon>
              </td>
              <td v-if="assignment.d_file==null">
                <v-icon color="info" @click="openForm(assignment.id_a)">mdi-cloud-upload</v-icon>
              </td>
              <td v-else>
                <v-icon color="success">mdi-cloud-check</v-icon>
              </td>
              <td>
                <a @click="open(assignment.d_file)">{{assignment.d_filename}}</a>
              </td>
            </tr>
          </tbody>
        </v-simple-table>
      </v-col>
    </v-row>
    <v-dialog v-model="add" max-width="450">
      <v-card>
        <v-card-title>Upload delivery</v-card-title>
        <v-card-text>
          <v-form ref="addForm" class="ma-3" @submit.prevent="addDelivery">
            <v-file-input
              label="Delivery"
              v-model="deliveryToAdd.d_file"
              :rules="[(v) => !!v || 'File is required']"
            ></v-file-input>
            <v-btn block class="success mt-3" type="submit">send</v-btn>
          </v-form>
        </v-card-text>
      </v-card>
    </v-dialog>
  </v-container>
</template>

<script>
import NavbarS from "@/components/NavbarS";

export default {
  data: () => ({
    student: {},
    course: {},
    assignmentsList: [],
    deliveryToAdd: {},
    alert: { show: false },
    add: false
  }),
  methods: {
    open(link) {
      window.open(link);
    },
    openForm(id_a) {
      this.deliveryToAdd.id_a = id_a;
      this.add = true;
    },
    async addDelivery() {
      let valid = this.$refs.addForm.validate();
      if (valid) {
        try {
          const delivery = new FormData();
          delivery.append("id", this.student.id);
          delivery.append("id_a", this.deliveryToAdd.id_a);
          delivery.append("d_file", this.deliveryToAdd.d_file);

          const res = await this.axios.post("/student/delivery", delivery);

          const index = this.assignmentsList.findIndex(
            a => (a.id_a == this.deliveryToAdd.id_a)
          );
          this.assignmentsList[index].d_file = res.data.d_file;
          this.assignmentsList[index].d_filename = res.data.d_filename;
          this.add = false;
          this.$refs.addForm.reset();
          this.alert = {
            show: true,
            type: "success",
            message: res.data.message
          };
        } catch (error) {}
      }
    }
  },
  components: {
    NavbarS
  },
  created: async function() {
    this.student = JSON.parse(sessionStorage.getItem("session"));
    if (this.student == null) {
      this.$router.push("/");
    } else if (this.student.role != "student") {
      this.$router.push("/profile");
    } else {
      try {
        const res = await this.axios.get(
          `/student/assignments/${this.$route.params.id_c}/${this.student.id}`
        );
        this.course = res.data.course;
        this.assignmentsList = res.data.assignments;
      } catch (error) {
        console.log(error);
      }
    }
  }
};
</script>