<template>
  <v-container>
    <NavbarP v-if="user.role=='professor'" :p_name="user.name"/>
    <NavbarS v-else :s_name="user.name"/>
    <v-row justify="center">
      <v-col md="6" sm="6">
        <v-card>
          <v-card-title class="text-uppercase">{{user.role}}</v-card-title>
          <v-card-text>
            <h2>{{user.name}}</h2>
            <h4>{{user.email}}</h4>
          </v-card-text>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import NavbarP from "@/components/NavbarP";
import NavbarS from "@/components/NavbarS";

export default {
  data: () => ({
    user: { role: "", name: "", email: "" }
  }),
  created: function() {
    this.user = JSON.parse(sessionStorage.getItem("session"));
    if (this.user == null) {
      this.$router.push("/");
    }
  },
    components: {
    NavbarP,
    NavbarS
  }
};
</script>